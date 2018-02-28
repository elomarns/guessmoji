defmodule Guessmoji.Media.Emoji do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guessmoji.Media.{Language, Category, Emoji}

  schema "emojis" do
    field(:content, :string)
    field(:decoded_content, :string)
    field(:tip, :string)

    belongs_to(:language, Language)
    belongs_to(:category, Category)

    timestamps()
  end

  def changeset(%Emoji{} = emoji, attrs) do
    emoji
    |> cast(attrs, [:content, :decoded_content, :tip, :language_id, :category_id])
    |> validate_required([:content, :decoded_content, :language_id, :category_id])
  end
end
