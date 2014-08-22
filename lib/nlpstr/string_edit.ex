#
# Copyright ©2014 The exnlpt Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
#
defmodule Exnlpt.StringEdit do
  @moduledoc "String Edit Distance algorithm, also known as Levenshtein, measures the similarity of two strings by returning the number of steps it would take to transform string_1 into string_2."

  @doc """
  Recurse each charlist with new HashDict yeilding list.
  Recurse head|tail for remainder strings with cache.
  Check for cache key against chars and return if true, else chain cache results with chars and reamainders incrementing for each diff and store result.

    EX:
      Exnlpt.StringEdit.distance('this', 'that')
  """
  def distance(charlist_1, charlist_2) do
    {list, _} = distance(charlist_1, charlist_2, HashDict.new)
    list
  end

  defp store_result(key, result, cache) do
    {result, HashDict.put(cache, key, result)}
  end

  defp distance(charlist_1, []=charlist_2, cache) do
    store_result({charlist_1, charlist_2}, length(charlist_1), cache)
  end

  defp distance([]=charlist_1, charlist_2, cache) do
    store_result({charlist_1, charlist_2}, length(charlist_2), cache)
  end

  defp distance([x|rest1], [x|rest2], cache) do
    distance(rest1, rest2, cache)
  end

  defp distance([_|rest1]=charlist_1, [_|rest2]=charlist_2, cache) do
    case HashDict.has_key?(cache, {charlist_1, charlist_2}) do
      true -> {HashDict.get(cache, {charlist_1, charlist_2}), cache}
      false ->
        {l1, c1} = distance(charlist_1, rest2, cache)
        {l2, c2} = distance(rest1, charlist_2, c1)
        {l3, c3} = distance(rest1, rest2, c2)

        min = :lists.min([l1, l2, l3]) + 1
        store_result({charlist_1, charlist_2}, min, c3)
    end
  end
end
