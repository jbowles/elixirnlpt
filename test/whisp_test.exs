defmodule ExnlptTest.WhispTest do
use ExUnit.Case

  test "Upcase Whisp parser returns all upper case results" do
    s = "Count words in and in and in this Sentence for a sentence COUNT."
    res = Exnlpt.Token.count({:up,:ok}, s)
    Enum.map(res, &( assert :true == String.match?(hd(elem(&1, 0)), ~r/[A-Z]/) ) )
  end

  test "Count for all words is equal to sample and upcase" do
    s = "one two three four five six seven eight nine ten."
    up = Exnlpt.Token.count({:up,:ok}, s)
    assert 10 === length(up)
  end

  test "Count for all words is equal to sample and downcase" do
    s = "one two three four five six seven."
    down = Exnlpt.Token.count({:down,:ok}, s)
    assert 7 === length(down)
  end

  test "Count for all words is equal to sample and no case" do
    s = "one two three four."
    ok = Exnlpt.Token.count({:ok,:ok}, s)
    assert 4 === length(ok)
  end

end
