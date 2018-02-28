defmodule Guessmoji.Media.EmojiTest do
  use Guessmoji.DataCase, async: true
  alias Guessmoji.Media.Emoji

  test "changeset with valid attributes" do
    changeset = Emoji.changeset(%Emoji{}, emoji_valid_attrs())
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Emoji.changeset(%Emoji{}, emoji_invalid_attrs())
    refute changeset.valid?
  end

  test "changeset requires a content" do
    changeset = Emoji.changeset(%Emoji{}, Map.put(emoji_valid_attrs(), :content, nil))
    assert %{content: ["can't be blank"]} = errors_on(changeset)
  end

  test "changeset requires a decoded content" do
    changeset = Emoji.changeset(%Emoji{}, Map.put(emoji_valid_attrs(), :decoded_content, nil))
    assert %{decoded_content: ["can't be blank"]} = errors_on(changeset)
  end

  test "changeset requires a language_id" do
    changeset = Emoji.changeset(%Emoji{}, Map.put(emoji_valid_attrs(), :language_id, nil))
    assert %{language_id: ["can't be blank"]} = errors_on(changeset)
  end

  test "changeset requires a category_id" do
    changeset = Emoji.changeset(%Emoji{}, Map.put(emoji_valid_attrs(), :category_id, nil))
    assert %{category_id: ["can't be blank"]} = errors_on(changeset)
  end
end
