defmodule Guessmoji.Media.CategoryTest do
  use Guessmoji.DataCase, async: true
  alias Guessmoji.Media.Category

  @valid_attrs %{name: "Books"}
  @invalid_attrs %{name: nil}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset requires a name" do
    changeset = Category.changeset(%Category{}, Map.put(@valid_attrs, :name, nil))
    assert %{name: ["can't be blank"]} = errors_on(changeset)
  end
end
