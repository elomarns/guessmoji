defmodule Guessmoji.Repo.Migrations.CreateEmojis do
  use Ecto.Migration

  def change do
    create table(:emojis) do
      add(:content, :text)
      add(:decoded_content, :text)
      add(:tip, :text)
      add(:language_id, references(:languages, on_delete: :nilify_all))
      add(:category_id, references(:categories, on_delete: :nilify_all))

      timestamps()
    end

    create(index(:emojis, [:language_id]))
    create(index(:emojis, [:category_id]))
    create(unique_index(:emojis, [:content, :decoded_content]))
  end
end
