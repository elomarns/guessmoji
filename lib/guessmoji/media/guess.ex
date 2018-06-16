defmodule Guessmoji.Media.Guess do
  use Ecto.Schema
  import Ecto.Changeset
  import Guessmoji.{ChangesetChangesTrimmer, StringNormalizer}
  alias Guessmoji.Media
  alias Guessmoji.Media.{Emoji, Guess}

  schema "guesses" do
    field(:content, :string)
    field(:correct, :boolean)

    belongs_to(:emoji, Emoji)

    timestamps()
  end

  def changeset(%Guess{} = guess, attrs) do
    guess
    |> cast(attrs, [:content, :emoji_id])
    |> validate_required([:content, :emoji_id])
    |> trim(:content)
    |> put_correct()
  end

  defp put_correct(%Ecto.Changeset{valid?: true, changes: %{content: _content}} = changeset) do
    guess = struct(Guess, changeset.changes)
    emoji = Media.get_emoji!(guess.emoji_id)
    put_change(changeset, :correct, correct?(guess, emoji))
  end

  defp put_correct(%Ecto.Changeset{} = changeset) do
    changeset
  end

  defp correct?(%Guess{} = guess, %Emoji{} = emoji) do
    normalize(guess.content) == normalize(emoji.decoded_content)
  end
end
