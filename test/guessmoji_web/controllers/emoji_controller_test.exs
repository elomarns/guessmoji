defmodule GuessmojiWeb.EmojiControllerTest do
  use GuessmojiWeb.ConnCase
  alias Guessmoji.Media

  describe "new emoji" do
    test "renders form", %{conn: conn} do
      conn = get(conn, emoji_path(conn, :new))
      assert html_response(conn, 200) =~ "New Emoji"
    end
  end

  @default_language Application.get_env(:guessmoji, :default_language)

  defp create_default_language(_) do
    Media.create_language(%{name: @default_language})
    :ok
  end

  @default_category Application.get_env(:guessmoji, :default_category)

  defp create_default_category(_) do
    Media.create_category(%{name: @default_category})
    :ok
  end

  describe "create emoji" do
    setup [:create_default_language, :create_default_category]

    test "default language id is inserted on emoji params", %{conn: conn} do
      conn = post(conn, emoji_path(conn, :create), emoji: %{})
      assert %{"language_id" => language_id} = conn.params["emoji"]
      assert @default_language == Media.get_language!(language_id).name
    end

    test "default category id is inserted on emoji params", %{conn: conn} do
      conn = post(conn, emoji_path(conn, :create), emoji: %{})
      assert %{"category_id" => category_id} = conn.params["emoji"]
      assert @default_category == Media.get_category!(category_id).name
    end

    test "redirects to new guess when data is valid", %{conn: conn} do
      valid_attrs = %{
        content: "👑🐒",
        decoded_content: "King Kong"
      }

      conn = post(conn, emoji_path(conn, :create), emoji: valid_attrs)
      assert %{emoji_id: emoji_id} = redirected_params(conn)
      assert redirected_to(conn) == emoji_guess_path(conn, :new, emoji_id)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, emoji_path(conn, :create), emoji: emoji_invalid_attrs())
      assert html_response(conn, 200) =~ "New Emoji"
    end
  end
end
