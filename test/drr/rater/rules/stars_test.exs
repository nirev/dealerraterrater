defmodule DRR.Rater.Rules.StarsTest do
  use ExUnit.Case
  alias DRR.Rater.Rules.Stars

  test "returns zero if below forty" do
    entry = %{rating: Enum.random(1..39)}

    assert Stars.apply(entry) == 0
  end

  test "returns weighted by forty" do
    rating = Enum.random(40..100)
    entry = %{rating: rating}

    assert Stars.apply(entry) == rating / 40
  end
end
