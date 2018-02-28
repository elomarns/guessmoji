defmodule Guessmoji.Media.LanguageTest do
  use Guessmoji.DataCase, async: true
  alias Guessmoji.Media.Language

  test "changeset with valid attributes" do
    changeset = Language.changeset(%Language{}, language_valid_attrs())
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Language.changeset(%Language{}, language_invalid_attrs())
    refute changeset.valid?
  end

  test "changeset requires a name" do
    changeset = Language.changeset(%Language{}, Map.put(language_valid_attrs(), :name, nil))
    assert %{name: ["can't be blank"]} = errors_on(changeset)
  end
end
