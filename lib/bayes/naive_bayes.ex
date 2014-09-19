#
# Copyright ©2014 The exnlpt Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
#
defmodule Exnlpt.NaiveBayes do
  @moduledoc """
  Naive Bayesian classification for text.

  EX:
    Exnlpt.NaiveBayes.categories([:cat1, :cat2, :cat3])
  """

  def categories(catgs), do: categories(HashDict.new, catgs)
  defp categories(cat, [head|tail]) do
    cat = HashDict.put(cat, head, HashDict.new)
    categories cat, tail
  end
  defp categories(cat, []), do: cat

end
