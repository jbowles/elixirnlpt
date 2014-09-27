#
# Copyright ©2014 The exnlpt Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
#
defmodule Exnlpt.BayesLexer do
  @moduledoc """
  Provides basic data lexing and data cleaning functions for passing data to 
  Bayesian analysis.

  EX:
    Exnlpt.BayesLexer.index_frequency("Got some awesome text here for here and awesome")
  """

  def index_frequency(text) do
    clean(text) |> naive_index
  end

  def clean(text) do
    String.split(text) 
  end

  def naive_index(word_array) do
    Enum.map(word_array, &String.downcase/1 ) |> Exnlpt.count_unique
  end
end
