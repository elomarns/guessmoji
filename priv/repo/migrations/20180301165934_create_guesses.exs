defmodule Guessmoji.Repo.Migrations.CreateGuesses do
  use Ecto.Migration

  def change do
    create table(:guesses) do
      add(:content, :string)
      add(:emoji_id, references(:emojis, on_delete: :delete_all))

      timestamps()
    end

    create(index(:guesses, [:emoji_id]))
  end
end
