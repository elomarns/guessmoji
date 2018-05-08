defmodule Guessmoji.StringNormalizer do
  def normalize(""), do: ""

  def normalize(string) when is_binary(string) do
    string
    |> String.downcase()
    |> String.trim()
    |> String.replace(~r/\s+/, " ")
    |> normalize_symbols()
    |> normalize_numbers()
  end

  @regex_for_symbols_to_remove ~r/:|-|\.|,|;|'|"/
  defp normalize_symbols(string) do
    string
    |> String.replace(@regex_for_symbols_to_remove, "")
    |> String.replace(~r/&/, "and")
    |> String.replace(~r/@/, "a")
  end

  @roman_and_decimals [
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
  defp normalize_numbers(string) do
    Enum.reduce(@roman_and_decimals, string, &replace_roman_by_decimal/2)
  end

  defp replace_roman_by_decimal({roman, decimal}, string) do
    String.replace(string, roman, decimal)
  end
end
