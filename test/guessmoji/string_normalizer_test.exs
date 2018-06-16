defmodule Guessmoji.StringNormalizerTest do
  use Guessmoji.DataCase, async: true
  import Guessmoji.StringNormalizer

  test "normalize/1 downcases the string" do
    assert normalize("ELOMAR") == "elomar"
  end

  test "normalize/1 removes all whitespace from string" do
    assert normalize("  e l  o  m           ar ") == "elomar"
  end

  @punctuation_to_remove [
    ":",
    "-",
    ".",
    ",",
    ";",
    "`",
    "'",
    "\"",
    "?",
    "!",
    "[",
    "]",
    "{",
    "}",
    "(",
    ")",
    "/",
    "\\"
  ]
  test "normalize/1 removes punctuation" do
    Enum.each(@punctuation_to_remove, fn punctuation ->
      assert normalize(punctuation) == ""
    end)
  end

  @symbols_and_text_equivalents [
    {"&", "and"},
    {"@", "a"}
  ]
  test "normalize/1 replaces symbols by text" do
    Enum.each(@symbols_and_text_equivalents, fn {symbol, text} ->
      assert normalize(symbol) == text
    end)
  end

  @roman_and_decimals_equivalents [
    {"xxiv", "24"},
    {"xxv", "25"},
    {"xxiii", "23"},
    {"xxii", "22"},
    {"xxi", "21"},
    {"xix", "19"},
    {"xx", "20"},
    {"xviii", "18"},
    {"xvii", "17"},
    {"xvi", "16"},
    {"xiv", "14"},
    {"xv", "15"},
    {"xiii", "13"},
    {"xii", "12"},
    {"xi", "11"},
    {"ix", "9"},
    {"x", "10"},
    {"viii", "8"},
    {"vii", "7"},
    {"vi", "6"},
    {"iv", "4"},
    {"v", "5"},
    {"iii", "3"},
    {"ii", "2"},
    {"i", "1"}
  ]
  test "normalize/1 replaces roman numbers by decimals numbers" do
    Enum.each(@roman_and_decimals_equivalents, fn {roman, decimal} ->
      assert normalize(roman) == decimal
    end)
  end
end
