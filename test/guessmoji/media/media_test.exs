defmodule Guessmoji.MediaTest do
  use Guessmoji.DataCase
  alias Guessmoji.Media

  describe "languages" do
    alias Guessmoji.Media.Language

    test "list_languages/0 returns all languages" do
      language = language_fixture()
      assert Media.list_languages() == [language]
    end

    test "get_language!/1 returns the language with given id" do
      language = language_fixture()
      assert Media.get_language!(language.id) == language
    end

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

    test "update_language/2 with valid data updates the language" do
      language = language_fixture()
      update_attrs = language_update_attrs()
      assert {:ok, %Language{} = language} = Media.update_language(language, update_attrs)
      assert language.name == update_attrs.name
    end

    test "update_language/2 with invalid data returns error changeset" do
      language = language_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Media.update_language(language, language_invalid_attrs())

      assert language == Media.get_language!(language.id)
    end

    test "delete_language/1 deletes the language" do
      language = language_fixture()
      assert {:ok, %Language{}} = Media.delete_language(language)
      assert_raise Ecto.NoResultsError, fn -> Media.get_language!(language.id) end
    end

    test "change_language/1 returns a language changeset" do
      language = language_fixture()
      assert %Ecto.Changeset{} = Media.change_language(language)
    end
  end

  describe "categories" do
    alias Guessmoji.Media.Category

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Media.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Media.get_category!(category.id) == category
    end

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

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = category_update_attrs()
      assert {:ok, %Category{} = category} = Media.update_category(category, update_attrs)
      assert category.name == update_attrs.name
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Media.update_category(category, category_invalid_attrs())

      assert category == Media.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Media.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Media.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Media.change_category(category)
    end
  end

  describe "emojis" do
    alias Guessmoji.Media.Emoji

    test "list_emojis/0 returns all emojis" do
      emoji = emoji_fixture()
      assert Media.list_emojis() == [emoji]
    end

    test "get_emoji!/1 returns the emoji with given id" do
      emoji = emoji_fixture()
      assert Media.get_emoji!(emoji.id) == emoji
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

    test "update_emoji/2 with valid data updates the emoji" do
      emoji = emoji_fixture()
      update_attrs = emoji_update_attrs()
      assert {:ok, %Emoji{} = emoji} = Media.update_emoji(emoji, update_attrs)
      assert emoji.content == update_attrs.content
      assert emoji.decoded_content == update_attrs.decoded_content
      assert emoji.tip == update_attrs.tip
      assert emoji.language_id == update_attrs.language_id
      assert emoji.category_id == update_attrs.category_id
    end

    test "update_emoji/2 with invalid data returns error changeset" do
      emoji = emoji_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_emoji(emoji, emoji_invalid_attrs())
      assert emoji == Media.get_emoji!(emoji.id)
    end

    test "delete_emoji/1 deletes the emoji" do
      emoji = emoji_fixture()
      assert {:ok, %Emoji{}} = Media.delete_emoji(emoji)
      assert_raise Ecto.NoResultsError, fn -> Media.get_emoji!(emoji.id) end
    end

    test "change_emoji/1 returns a emoji changeset" do
      emoji = emoji_fixture()
      assert %Ecto.Changeset{} = Media.change_emoji(emoji)
    end
  end

  describe "guesses" do
    alias Guessmoji.Media.Guess

    test "list_guesses/0 returns all guesses" do
      guess = guess_fixture()
      assert Media.list_guesses() == [guess]
    end

    test "get_guess!/1 returns the guess with given id" do
      guess = guess_fixture()
      assert Media.get_guess!(guess.id) == guess
    end

    test "create_guess/1 with valid data creates a guess" do
      valid_attrs = guess_valid_attrs()
      assert {:ok, %Guess{} = guess} = Media.create_guess(valid_attrs)
      assert guess.emoji_id == valid_attrs.emoji_id
      assert guess.content == valid_attrs.content
    end

    test "create_guess/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_guess(guess_invalid_attrs())
    end

    test "update_guess/2 with valid data updates the guess" do
      guess = guess_fixture()
      update_attrs = guess_update_attrs()
      assert {:ok, %Guess{} = guess} = Media.update_guess(guess, update_attrs)
      assert guess.emoji_id == update_attrs.emoji_id
      assert guess.content == update_attrs.content
    end

    test "update_guess/2 with invalid data returns error changeset" do
      guess = guess_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_guess(guess, guess_invalid_attrs())
      assert guess == Media.get_guess!(guess.id)
    end

    test "delete_guess/1 deletes the guess" do
      guess = guess_fixture()
      assert {:ok, %Guess{}} = Media.delete_guess(guess)
      assert_raise Ecto.NoResultsError, fn -> Media.get_guess!(guess.id) end
    end

    test "change_guess/1 returns a guess changeset" do
      guess = guess_fixture()
      assert %Ecto.Changeset{} = Media.change_guess(guess)
    end
  end
end
