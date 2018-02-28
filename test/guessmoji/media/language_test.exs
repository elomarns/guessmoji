defmodule Guessmoji.Media.LanguageTest do
  use Guessmoji.DataCase, async: true
  alias Guessmoji.Media.Language

  @valid_attrs %{name: "Portuguese"}
  @invalid_attrs %{name: nil}

  test "changeset with valid attributes" do
    changeset = Language.changeset(%Language{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Language.changeset(%Language{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset requires a name" do
    changeset = Language.changeset(%Language{}, Map.put(@valid_attrs, :name, nil))
    assert %{name: ["can't be blank"]} = errors_on(changeset)
  end
end
