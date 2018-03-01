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
end
