defmodule DRR.Parser do
  @moduledoc """
  Parses a reviews page into multiple review entries
  """

  @type entry :: %{
          date: binary(),
          rating: integer(),
          body: binary(),
          user: binary(),
          employees: [%{name: binary(), rating: integer()}]
        }
  @type entries :: [[entry]]
  @type next_page :: binary() | nil

  @spec parse(binary) :: {:error, binary()} | {:ok, entries, next_page}
  def parse(body) do
    with {:ok, doc} <- Floki.parse_document(body) do
      entries =
        doc
        |> Floki.find(".review-entry")
        |> Enum.map(&parse_entry/1)

      next =
        doc
        |> Floki.find(~s(link[rel="next"]))
        |> Floki.attribute("href")
        |> List.first()

      {:ok, entries, next}
    end
  end

  defp parse_entry(entry) do
    %{
      id: get_id(entry),
      date: get_text(entry, ".review-date div:first-child"),
      rating: get_rating(entry, ".dealership-rating .rating-static"),
      body:
        get_text(entry, ".review-wrapper .review-title") <>
          " " <>
          get_text(entry, ".review-wrapper .review-whole"),
      user:
        get_text(entry, ".review-wrapper > div > span.notranslate") |> String.replace("by ", ""),
      employees: get_employees(entry)
    }
  end

  defp get_text(doc, selector) do
    doc
    |> Floki.find(selector)
    |> Floki.text()
    |> String.trim()
  end

  defp get_id(entry) do
    entry
    |> Floki.attribute(".review-entry > a:first-child", "name")
    |> List.first()
    |> String.trim()
  end

  defp get_rating(entry, selector) do
    class =
      entry
      |> Floki.attribute(selector, "class")
      |> List.first()

    [_, rating] = Regex.run(~r/.*rating-(\d{2}).*/, class)
    String.to_integer(rating)
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
