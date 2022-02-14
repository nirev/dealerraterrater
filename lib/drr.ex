defmodule DRR do
  @moduledoc """
  DealerRaterRater rates dealer reviews from Dealer Rater
  """

  alias DRR.Fetcher
  alias DRR.Rater

  @doc """
  Runs with with default arguments
  """
  def run do
    {:ok, _} = Application.ensure_all_started(:dealer_rater_rater)
    url = Application.get_env(:dealer_rater_rater, :base_url)
    num_pages = 5

    url
    |> Fetcher.fetch(num_pages)
    |> Enum.flat_map(&rate_page/1)
    |> Enum.sort_by(fn {rate, _} -> rate end, :desc)
    |> Enum.take(3)
    |> Enum.map(fn {_rate, entry} -> entry end)
    |> print()
  end

  defp rate_page(page) do
    Enum.map(page, fn entry ->
      {Rater.rate(entry, Rater.default_rules()), entry}
    end)
  end

  defp print(entries) do
    for entry <- entries do
      IO.puts(Jason.encode!(entry))
    end
  end
end
