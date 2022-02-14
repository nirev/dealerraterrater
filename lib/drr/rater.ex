defmodule DRR.Rater do
  @moduledoc """
  Rates reviews entries according to the list of rules
  """

  alias DRR.Rater.Rule
  alias DRR.Rater.Rules

  @type weighted_rule :: {weight :: non_neg_integer(), rule :: module()}

  @spec rate(DRR.Parser.entry(), [weighted_rule]) :: float
  def rate(entry, rules) do
    {total_weight, sum} =
      rules
      |> Enum.map(fn {weight, rule} ->
        {weight, Rule.apply(rule, entry)}
      end)
      |> Enum.reduce({0, 0}, fn {rule_weight, rule_value}, {total_weight, sum} ->
        {total_weight + rule_weight, sum + rule_value * rule_weight}
      end)

    sum / total_weight
  end

  def default_rules() do
    [
      {2, Rules.Intensity},
      {1, Rules.Stars}
    ]
  end
end
