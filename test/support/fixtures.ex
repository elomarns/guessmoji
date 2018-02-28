defmodule Guessmoji.Fixtures do
  alias Guessmoji.Media

  def language_valid_attrs, do: %{name: "English"}
  def language_update_attrs, do: %{name: "English (US)"}
  def language_invalid_attrs, do: %{name: nil}

  def language_fixture(attrs \\ %{}) do
    {:ok, language} =
      attrs
      |> Enum.into(language_valid_attrs())
      |> Media.create_language()

    language
  end

  def category_valid_attrs, do: %{name: "Movies"}
  def category_update_attrs, do: %{name: "Games"}
  def category_invalid_attrs, do: %{name: nil}

  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(category_valid_attrs())
      |> Media.create_category()

    category
  end

  def emoji_valid_attrs do
    %{
      content: "⭐🔫👻🔪",
      decoded_content: "Star Wars: Episode I – The Phantom Menace",
      tip: nil,
      language_id: language_fixture(%{name: "English"}).id,
      category_id: category_fixture(%{name: "Movies"}).id
    }
  end

  def emoji_update_attrs do
    %{
      content: "🆙",
      decoded_content: "Up",
      tip: "This movie has the best introduction scene ever!",
      language_id: language_fixture(%{name: "English (UK)"}).id,
      category_id: category_fixture(%{name: "Pixar Movies"}).id
    }
  end

  def emoji_invalid_attrs do
    %{
      content: nil,
      decoded_content: nil,
      tip: nil,
      language_id: nil,
      category_id: nil
    }
  end

  def emoji_fixture(attrs \\ %{}) do
    {:ok, emoji} =
      attrs
      |> Enum.into(emoji_valid_attrs())
      |> Media.create_emoji()

    emoji
  end
end
