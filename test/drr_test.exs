defmodule DRRTest do
  use ExUnit.Case

  import Tesla.Mock
  import ExUnit.CaptureIO

  test "does not crash" do
    mock(fn
      %{method: :get} ->
        %Tesla.Env{
          status: 200,
          body: File.read!(Path.join(__DIR__, "fixtures/page1.html"))
        }
    end)

    with_io(fn ->
      assert DRR.run()
    end)
  end
end
