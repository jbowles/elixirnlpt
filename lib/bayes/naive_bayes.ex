#
# Copyright ©2014 The exnlpt Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
#
defmodule Exnlpt.NaiveBayes do
  @moduledoc """
  Naive Bayesian classification for text.

  EX:
    Exnlpt.NaiveBayes.init([:cat1, :cat2, :cat3])
  """

  #def init(catgs) do 
  #  categories(catgs)
  #  HashDict.new
  #end

  # need to create instance variable for categories
  def categories(catgs), do: categories(HashDict.new, catgs)
  defp categories(cat, [head|tail]) do
    cat = HashDict.put(cat, head, HashDict.new)
    categories cat, tail
  end
  defp categories(cat, []), do: cat

  # need to create instance variable for category counts
  #def category_counts(catgy) do 
  #  h = HashDict.new
  #  h.put(h, catgy, 0)
  #end
  def category_counts({catgy, hash}) do
    hash.update hash, catgy, 1, &(&1 + 1)
  end

  #def train({category, text}) do
  #  category_counts({category, :category_counts})
  #end

end
