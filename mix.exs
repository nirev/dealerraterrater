defmodule DRR.MixProject do
  use Mix.Project

  def project do
    [
      app: :dealer_rater_rater,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "> 0.0.0"},
      {:floki, "> 0.0.0"},
      {:hackney, "> 0.0.0"},
      {:jason, "> 0.0.0"}
    ]
  end
end
