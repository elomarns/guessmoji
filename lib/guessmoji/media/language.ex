defmodule Guessmoji.Media.Language do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guessmoji.Media.Language

  schema "languages" do
    field(:name, :string)

    timestamps()
  end

  def changeset(%Language{} = language, attrs) do
    language
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
