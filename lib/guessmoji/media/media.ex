defmodule Guessmoji.Media do
  import Ecto.Query, warn: false
  alias Guessmoji.Repo

  alias Guessmoji.Media.Language

  def get_language_by(fields), do: Repo.get_by(Language, fields)

  def create_language(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
  end

  alias Guessmoji.Media.Category

  def get_category_by(fields), do: Repo.get_by(Category, fields)

  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  alias Guessmoji.Media.Emoji

  def get_emoji!(id), do: Repo.get!(Emoji, id)

  def get_random_emoji(excluded_ids) do
    Emoji.random(excluded_ids)
    |> Repo.one()
  end

  def create_emoji(attrs \\ %{}) do
    %Emoji{}
    |> Emoji.changeset(attrs)
    |> Repo.insert()
  end

  def change_emoji(%Emoji{} = emoji) do
    Emoji.changeset(emoji, %{})
  end

  alias Guessmoji.Media.Guess

  def create_guess(attrs \\ %{}) do
    %Guess{}
    |> Guess.changeset(attrs)
    |> Repo.insert()
  end

  def change_guess(%Guess{} = guess) do
    Guess.changeset(guess, %{})
  end
end
