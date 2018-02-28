defmodule Guessmoji.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add(:name, :string)

      timestamps()
    end
  end
end
