defmodule Guessmoji.Repo.Migrations.AddUniqueIndexToEmojis do
  use Ecto.Migration

  def change do
    create(unique_index(:emojis, [:content, :decoded_content]))
  end
end
