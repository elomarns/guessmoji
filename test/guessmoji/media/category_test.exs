defmodule Guessmoji.Media.CategoryTest do
  use Guessmoji.DataCase, async: true
  alias Guessmoji.Media.Category

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, category_valid_attrs())
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, category_invalid_attrs())
    refute changeset.valid?
  end

  test "changeset requires a name" do
    changeset = Category.changeset(%Category{}, Map.put(category_valid_attrs(), :name, nil))
    assert %{name: ["can't be blank"]} = errors_on(changeset)
  end
end
