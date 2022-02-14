defmodule DRR.Rater.Rule do
  @moduledoc """
  Behaviour for Rating Rules
  """
  alias DRR.Parser

  @callback apply(rule :: module(), Parser.entry()) :: non_neg_integer()

  @spec apply(rule :: module(), Parser.entry()) :: non_neg_integer()
  def apply(rule, entry) do
    rule.apply(entry)
  end
end
