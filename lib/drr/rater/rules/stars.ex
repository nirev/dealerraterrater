defmodule DRR.Rater.Rules.Stars do
  @moduledoc """
  Rates entries according to stars

  Lately, I've been, I've been losing sleep
  Dreaming about the things that we could be
  But, baby, I've been, I've been praying hard
  Said no more counting dollars
  We'll be counting stars
  Yeah, we'll be counting stars
  """

  def apply(entry) do
    if entry.rating > 40 do
      entry.rating / 40
    else
      0
    end
  end
end
