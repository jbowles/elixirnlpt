defmodule ExnlptTest.WhispTest do
use ExUnit.Case

  test "Upcase Whisp parser returns all upper case results" do
    s = "Count words in and in and in this Sentence for a sentence COUNT."
    res = Exnlpt.Token.count(:up, s)
    Enum.map(res, &( assert :true == String.match?(hd(elem(&1, 0)), ~r/[A-Z]/) ) )
  end

  test "Count for all words is equal to sample and upcase" do
    s = "one two three four five six seven eight nine ten."
    up = Exnlpt.Token.count(:up, s)
    assert 10 === length(up)
  end

  test "Count for all words is equal to sample and downcase" do
    s = "one two three four five six seven."
    down = Exnlpt.Token.count(:down, s)
    assert 7 === length(down)
  end

  test "Count for all words is equal to sample and downcase" do
    s = "one two three four."
    ok = Exnlpt.Token.count(:ok, s)
    assert 4 === length(ok)
  end

end


#test "Heading at the start is interpreted correctly" do
#    {result, _} = Parser.parse(["Heading", "=====", ""])
#    assert result == [%Block.Heading{content: "Heading", level: 1}]
#  end
#
#  test "Heading at the end is interpreted correctly" do
#    {result, _} = Parser.parse(["", "Heading", "====="])
#    assert result == [%Block.Heading{content: "Heading", level: 1}]
#  end
#
#  test "Whitespace before and after code is ignored" do
#    {result, _} = Parser.parse(["", 
#                                "    line 1",
#                                "    line 2",
#                                "",
#                                "",
#                                "para"])
#
#    expect = [
#              %Earmark.Block.Code{attrs: nil, 
#                                  language: nil,
#                                  lines: ["line 1", "line 2"]},
#              %Earmark.Block.Para{attrs: nil, lines: ["para"]}
#             ]
#    assert result == expect
#  end
