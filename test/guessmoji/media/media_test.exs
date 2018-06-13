defmodule Guessmoji.MediaTest do
  use Guessmoji.DataCase
  alias Guessmoji.Media

  describe "languages" do
    alias Guessmoji.Media.Language

    test "get_language_by/1 returns the language with the given fields" do
      fields = language_valid_attrs()
      language = language_fixture(fields)
      assert Media.get_language_by(fields) == language
    end

    test "create_language/1 with valid data creates a language" do
      valid_attrs = language_valid_attrs()
      assert {:ok, %Language{} = language} = Media.create_language(valid_attrs)
      assert language.name == valid_attrs.name
    end

    test "create_language/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_language(language_invalid_attrs())
    end

    test "create_language/1 with an existing name returns error changeset" do
      language_fixture()

      assert {:error, %Ecto.Changeset{} = changeset} =
               Media.create_language(language_valid_attrs())

      assert %{name: ["has already been taken"]} = errors_on(changeset)
    end
  end

  describe "categories" do
    alias Guessmoji.Media.Category

    test "get_category_by/1 returns the category with the given fields" do
      fields = category_valid_attrs()
      category = category_fixture(fields)
      assert Media.get_category_by(fields) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = category_valid_attrs()
      assert {:ok, %Category{} = category} = Media.create_category(valid_attrs)
      assert category.name == valid_attrs.name
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_category(category_invalid_attrs())
    end

    test "create_category/1 with an existing name returns error changeset" do
      category_fixture()

      assert {:error, %Ecto.Changeset{} = changeset} =
               Media.create_category(category_valid_attrs())

      assert %{name: ["has already been taken"]} = errors_on(changeset)
    end
  end

  describe "emojis" do
    alias Guessmoji.Media.Emoji

    test "get_emoji!/1 returns the emoji with given id" do
      emoji = emoji_fixture()
      assert Media.get_emoji!(emoji.id) == emoji
    end

    test "get_random_emoji/1 returns a random emoji considering the excluded ids" do
      emoji = emoji_fixture(emoji_valid_attrs())
      assert Media.get_random_emoji([]) == emoji

      another_emoji = emoji_fixture(emoji_update_attrs())
      assert Media.get_random_emoji([emoji.id]) == another_emoji
    end

    test "create_emoji/1 with valid data creates a emoji" do
      valid_attrs = emoji_valid_attrs()
      assert {:ok, %Emoji{} = emoji} = Media.create_emoji(valid_attrs)
      assert emoji.content == valid_attrs.content
      assert emoji.decoded_content == valid_attrs.decoded_content
      assert emoji.tip == valid_attrs.tip
      assert emoji.language_id == valid_attrs.language_id
      assert emoji.category_id == valid_attrs.category_id
    end

    test "create_emoji/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_emoji(emoji_invalid_attrs())
    end

    test "create_emoji/1 with a duplicate pair of content and decoded content returns error changeset" do
      emoji_fixture()

      assert {:error, %Ecto.Changeset{} = changeset} = Media.create_emoji(emoji_valid_attrs())

      assert %{content: ["emoji content and decoded content have already been taken"]} =
               errors_on(changeset)
    end

    test "change_emoji/1 returns a emoji changeset" do
      emoji = emoji_fixture()
      assert %Ecto.Changeset{} = Media.change_emoji(emoji)
    end
  end

  describe "guesses" do
    alias Guessmoji.Media.Guess

    test "create_guess/1 with valid data creates a guess" do
      valid_attrs = guess_valid_attrs()
      assert {:ok, %Guess{} = guess} = Media.create_guess(valid_attrs)
      assert guess.emoji_id == valid_attrs.emoji_id
      assert guess.content == valid_attrs.content
    end

    test "create_guess/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_guess(guess_invalid_attrs())
    end

    test "change_guess/1 returns a guess changeset" do
      guess = guess_fixture()
      assert %Ecto.Changeset{} = Media.change_guess(guess)
    end
  end
end
