defmodule DRR.Fetcher do
  @moduledoc """
  Fetches pages from DealerRater and returns a json representation
  """

  def fetch(base_url, pages) when is_integer(pages) do
    do_fetch(base_url, pages, [])
  end

  defp do_fetch(nil, _, acc), do: Enum.reverse(acc)

  defp do_fetch(_url, 0, acc), do: Enum.reverse(acc)

  defp do_fetch(url, remaining, acc) do
    with {:ok, entries, next} <- fetch_page(url) do
      do_fetch(next, remaining - 1, [entries | acc])
    end
  end

  defp fetch_page(url) do
    with {:ok, %{body: body}} <- Tesla.get(url) do
      parse(body)
    end
  end

  defp parse(body) do
    with {:ok, doc} <- Floki.parse_document(body) do
      entries =
        doc
        |> Floki.find(".review-entry")
        |> Enum.map(&parse_entry/1)

      next =
        doc
        |> Floki.find(".sliding_pagination .next a")
        |> Floki.attribute("href")
        |> List.first()

      {:ok, entries, next}
    end
  end

  defp parse_entry(entry) do
    %{
      date: get_text(entry, ".review-date div:first-child"),
      rating: get_rating(entry, ".dealership-rating .rating-static"),
      body:
        get_text(entry, ".review-wrapper .review-title") <>
          " " <>
          get_text(entry, ".review-wrapper .review-whole"),
      user: get_text(entry, ".review-wrapper div span.notranslate") |> String.replace("by ", ""),
      employees: get_employees(entry)
    }
  end

  defp get_text(doc, selector) do
    doc
    |> Floki.find(selector)
    |> Floki.text()
    |> String.trim()
  end

  defp get_rating(entry, selector) do
    class =
      entry
      |> Floki.attribute(selector, "class")
      |> List.first()

    [_, rating] = Regex.run(~r/.*rating-(\d{2}).*/, class)
    rating
  end

  defp get_employees(entry) do
    entry
    |> Floki.find(".review-employee")
    |> Enum.map(fn employee ->
      %{
        name: get_text(employee, "div.table > div:nth-child(2) a") |> String.trim(),
        rating: get_rating(employee, ".rating-static")
      }
    end)
  end
end
