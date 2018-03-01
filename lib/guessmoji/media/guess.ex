defmodule Guessmoji.Media.Guess do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guessmoji.Media.{Emoji, Guess}

  schema "guesses" do
    field(:content, :string)

    belongs_to(:emoji, Emoji)

    timestamps()
  end

  def changeset(%Guess{} = guess, attrs) do
    guess
    |> cast(attrs, [:content, :emoji_id])
    |> validate_required([:content])
  end
end
