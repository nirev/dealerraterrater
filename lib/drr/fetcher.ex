defmodule DRR.Fetcher do
  @moduledoc """
  Fetches pages from DealerRater and returns a json representation
  """

  alias DRR.Parser

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
      Parser.parse(body)
    end
  end
end
