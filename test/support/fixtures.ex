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
    language_fields = %{name: "English"}
    category_fields = %{name: "Movies"}

    %{
      content: "⭐🔫👻🔪",
      decoded_content: "Star Wars: Episode I – The Phantom Menace",
      tip: nil,
      language_id:
        (Media.get_language_by(language_fields) || language_fixture(language_fields)).id,
      category_id:
        (Media.get_category_by(category_fields) || category_fixture(category_fields)).id
    }
  end

  def emoji_update_attrs do
    language_fields = %{name: "English (UK)"}
    category_fields = %{name: "Pixar Movies"}

    %{
      content: "🆙",
      decoded_content: "Up",
      tip: "This movie has the best introduction scene ever!",
      language_id:
        (Media.get_language_by(language_fields) || language_fixture(language_fields)).id,
      category_id:
        (Media.get_category_by(category_fields) || category_fixture(category_fields)).id
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

  def guess_valid_attrs do
    %{emoji_id: emoji_fixture().id, content: "Star Wars: Episode I – The Phantom Menace"}
  end

  def guess_update_attrs do
    %{emoji_id: emoji_fixture(emoji_update_attrs()).id, content: "That Balloon Movie"}
  end

  def guess_invalid_attrs do
    %{emoji_id: nil, content: nil}
  end

  def guess_fixture(attrs \\ %{}) do
    {:ok, guess} =
      attrs
      |> Enum.into(guess_valid_attrs())
      |> Media.create_guess()

    guess
  end
end
