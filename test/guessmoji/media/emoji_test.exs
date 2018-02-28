defmodule Guessmoji.Media.EmojiTest do
  use Guessmoji.DataCase, async: true
  alias Guessmoji.Media
  alias Guessmoji.Media.Emoji

  @valid_attrs %{
    content: "🐒👑",
    decoded_content: "King Kong",
    tip: nil
  }
  @invalid_attrs %{
    language_id: nil,
    category_id: nil,
    content: nil,
    decoded_content: nil,
    tip: nil
  }

  defp valid_attrs do
    {:ok, language} = Media.create_language(%{name: "English"})
    {:ok, category} = Media.create_category(%{name: "Movies"})

    Enum.into(@valid_attrs, %{
      language_id: language.id,
      category_id: category.id
    })
  end

  test "changeset with valid attributes" do
    changeset = Emoji.changeset(%Emoji{}, valid_attrs())
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Emoji.changeset(%Emoji{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset requires a content" do
    changeset = Emoji.changeset(%Emoji{}, Map.put(valid_attrs(), :content, nil))
    assert %{content: ["can't be blank"]} = errors_on(changeset)
  end

  test "changeset requires a decoded content" do
    changeset = Emoji.changeset(%Emoji{}, Map.put(valid_attrs(), :decoded_content, nil))
    assert %{decoded_content: ["can't be blank"]} = errors_on(changeset)
  end

  test "changeset requires a language_id" do
    changeset = Emoji.changeset(%Emoji{}, Map.put(valid_attrs(), :language_id, nil))
    assert %{language_id: ["can't be blank"]} = errors_on(changeset)
  end

  test "changeset requires a category_id" do
    changeset = Emoji.changeset(%Emoji{}, Map.put(valid_attrs(), :category_id, nil))
    assert %{category_id: ["can't be blank"]} = errors_on(changeset)
  end
end
