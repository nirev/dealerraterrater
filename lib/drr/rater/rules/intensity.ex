defmodule DRR.Rater.Rules.Intensity do
  @moduledoc """
  Rates an entry according to the number of intense adjetives used
  """

  @supergood [
    "awesome",
    "amazing",
    "excellent",
    "above and beyond",
    "far and beyond",
    "superb",
    "best",
    "fantastic"
  ]

  def apply(entry) do
    @supergood
    |> Enum.map(fn text ->
      String.contains?(entry.body, text)
    end)
    |> Enum.count(& &1)
  end
end
