defmodule Guessmoji.Media.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guessmoji.Media.Category

  schema "categories" do
    field(:name, :string)

    timestamps()
  end

  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
