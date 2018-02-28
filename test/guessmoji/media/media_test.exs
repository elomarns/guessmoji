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

  describe "categories" do
    alias Guessmoji.Media.Category

    @valid_attrs %{name: "Movies"}
    @update_attrs %{name: "Games"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Media.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Media.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Media.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Media.create_category(@valid_attrs)
      assert category.name == @valid_attrs.name
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Media.update_category(category, @update_attrs)
      assert category.name == @update_attrs.name
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_category(category, @invalid_attrs)
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
end
