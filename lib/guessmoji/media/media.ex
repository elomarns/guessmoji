defmodule Guessmoji.Media do
  import Ecto.Query, warn: false
  alias Guessmoji.Repo

  alias Guessmoji.Media.Language

  def list_languages do
    Repo.all(Language)
  end

  def get_language!(id), do: Repo.get!(Language, id)

  def create_language(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
  end

  def update_language(%Language{} = language, attrs) do
    language
    |> Language.changeset(attrs)
    |> Repo.update()
  end

  def delete_language(%Language{} = language) do
    Repo.delete(language)
  end

  def change_language(%Language{} = language) do
    Language.changeset(language, %{})
  end

  alias Guessmoji.Media.Category

  def list_categories do
    Repo.all(Category)
  end

  def get_category!(id), do: Repo.get!(Category, id)

  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end
end
