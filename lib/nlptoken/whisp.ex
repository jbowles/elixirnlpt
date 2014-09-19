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
    Exnlpt.Token.count({:up, :count}, "Count words in and in and in this Sentence for a sentence COUNT.")
    Exnlpt.Token.count({:ok, :ok}, "Count words in and in and in this Sentence for a sentence COUNT.")
  """
  @doc "Return HashDict with unique {word, count} with an upcase, downcase, or nil text normalizing type and sort numerical or alphabetical."
  def count({scase, sort_type}, sentence) do
    normalize({scase, sentence}) |> find_words |> count_unique |> sort_by(sort_type)
  end

  @doc "Sort by unique word count or alphabetically. Note that piped lists to Enum are the head arg, so the sort_type has to be the second arg"
  defp sort_by(unique_words,:count) do
    Enum.sort(unique_words,fn {_, v1,}, {_, v2} -> v1 > v2 end )
  end
  defp sort_by(unique_words,_) do
    Enum.sort(unique_words)
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

  @doc "Typical erlang pattern matching functions for options to normalize strings."
  def normalize({:down, str}) do
    String.downcase(str)
  end
  def normalize({:up, str}) do
    String.upcase(str)
  end
  def normalize({_, str}) do
    str
  end

end

