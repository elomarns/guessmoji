defmodule Guessmoji.StringNormalizer do
  def normalize(""), do: ""

  def normalize(string) when is_binary(string) do
    string
    |> String.downcase()
    |> replace_strings_by_its_equivalents()
  end

  @strings_and_its_equivalents [
    # Whitespace
    {~r/\s+/, ""},

    # Articles
    {~r/^the/, ""},
    {~r/^an?/, ""},

    # Punctuation
    {":", ""},
    {"-", ""},
    {".", ""},
    {",", ""},
    {";", ""},
    {"`", ""},
    {"'", ""},
    {"\"", ""},
    {"?", ""},
    {"!", ""},
    {"[", ""},
    {"]", ""},
    {"{", ""},
    {"}", ""},
    {"(", ""},
    {")", ""},
    {"/", ""},
    {"\\", ""},

    # Symbols
    {"&", "and"},
    {"@", "a"},

    # Numbers
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

  defp replace_strings_by_its_equivalents(string) do
    Enum.reduce(@strings_and_its_equivalents, string, &do_replace_strings_by_its_equivalents/2)
  end

  defp do_replace_strings_by_its_equivalents({original, equivalent}, string) do
    String.replace(string, original, equivalent)
  end
end
