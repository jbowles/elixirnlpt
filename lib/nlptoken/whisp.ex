#
# Copyright ©2014 The exnlpt Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
#
defmodule Exnlpt.Token do
  @moduledoc """
  WhiteSpace natural language tokenzier.
  The simplest kind of tokenizer on can ask for (and get).
  It splits on white space only.

  Of course if all you needed was white space split you could do that yourself with regular expressions. The WhiSP (White Space tokenizer) also give you a sorted count of all words.

  EX:
    Exnlpt.Token.count(:up, :count, "Count words in and in and in this Sentence for a sentence COUNT.")
  """
  @doc "Return HashDict with unique {word, count} with an upcase, downcase, or nil text normalizing type and sort numerical or alphabetical."
  def count(case, sort_type, sentence) do
    res = {case, sentence} |> normalize |> find_words 
    |> count_unique
    sort_by_unique(sort_type, res)
  end

  def sort_by_unique(sort_type,res) do
    case sort_type do
      :count ->
        Enum.sort(res, fn {_, v1}, {_, v2} -> v1 > v2 end )
      :alphabet ->
        Enum.sort(res)
    end
  end

  @doc "Recurse through list of words udpating the HashDict count for each unique word."
  def count_unique(words), do: count_unique(HashDict.new, words)
  defp count_unique(hash, [head|tail]) do
    hash = HashDict.update hash, head, 1, &(&1 + 1)
    count_unique hash, tail
  end
  defp count_unique(hash, []), do: hash

  defp find_words(s) do
    Regex.scan(~r/\w+/, s)
  end

  defp normalize(string_direction) do
    case string_direction do
      {:down, str} ->
        String.downcase(str)
      {:up, str} ->
        String.upcase(str)
      {_, str} ->
        str
    end
  end
end

