defmodule Guessmoji.MediaTest do
  use Guessmoji.DataCase

  alias Guessmoji.Media

  describe "languages" do
    alias Guessmoji.Media.Language

    @valid_attrs %{name: "English"}
    @update_attrs %{name: "English (US)"}
    @invalid_attrs %{name: nil}

    def language_fixture(attrs \\ %{}) do
      {:ok, language} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Media.create_language()

      language
    end

    test "list_languages/0 returns all languages" do
      language = language_fixture()
      assert Media.list_languages() == [language]
    end

    test "get_language!/1 returns the language with given id" do
      language = language_fixture()
      assert Media.get_language!(language.id) == language
    end

    test "create_language/1 with valid data creates a language" do
      assert {:ok, %Language{} = language} = Media.create_language(@valid_attrs)
      assert language.name == @valid_attrs.name
    end

    test "create_language/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_language(@invalid_attrs)
    end

    test "update_language/2 with valid data updates the language" do
      language = language_fixture()
      assert {:ok, %Language{} = language} = Media.update_language(language, @update_attrs)
      assert language.name == @update_attrs.name
    end

    test "update_language/2 with invalid data returns error changeset" do
      language = language_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_language(language, @invalid_attrs)
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
end
