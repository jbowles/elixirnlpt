#
# Copyright ©2014 The exnlpt Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
#
defmodule Exnlpt.Count do

  @doc "Recurse through list of words udpating the HashDict count for each unique word."
  def unique_words(word_list), do: count_unique(HashDict.new, word_list)
  defp count_unique(hash, [head|tail]) do
    hash = HashDict.update hash, head, 1, &(&1 + 1)
    count_unique hash, tail
  end
  defp count_unique(hash, []), do: hash
end
