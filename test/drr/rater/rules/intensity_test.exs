defmodule DRR.Rater.Rules.IntensityTest do
  use ExUnit.Case
  alias DRR.Rater.Rules.Intensity

  test "returns zero if no intense expressions" do
    entry = %{body: "it was ok"}

    assert Intensity.apply(entry) == 0
  end

  test "returns number of intense expressions" do
    entry = %{
      body:
        "I had an awesome experience, they went above and beyond to provide the best service ever!!!"
    }

    assert Intensity.apply(entry) == 3
  end
end
