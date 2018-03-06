defmodule Guessmoji.Media.GuessTest do
  use Guessmoji.DataCase
  alias Guessmoji.Media.Guess

  test "changeset with valid attributes" do
    changeset = Guess.changeset(%Guess{}, guess_valid_attrs())
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Guess.changeset(%Guess{}, guess_invalid_attrs())
    refute changeset.valid?
  end

  test "changeset requires a content" do
    changeset = Guess.changeset(%Guess{}, Map.put(guess_valid_attrs(), :content, nil))
    assert %{content: ["can't be blank"]} = errors_on(changeset)
  end

  test "changeset removes all leading and trailing whitespace on content" do
    valid_attrs =
      Map.put(
        guess_valid_attrs(),
        :content,
        "  Star Wars: Episode I – The Phantom Menace  "
      )

    changeset = Guess.changeset(%Guess{}, valid_attrs)
    content = get_change(changeset, :content)
    assert content == "Star Wars: Episode I – The Phantom Menace"
  end

  test "changeset fills the correct field according to the guess" do
    changeset = Guess.changeset(%Guess{}, guess_valid_attrs())
    is_correct = get_change(changeset, :correct)
    assert is_correct

    changeset = Guess.changeset(%Guess{}, guess_update_attrs())
    is_correct = get_change(changeset, :correct)
    refute is_correct
  end
end
