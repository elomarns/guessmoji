defmodule GuesmojiWeb.GuessControllerTest do
  use GuessmojiWeb.ConnCase

  setup %{conn: conn} do
    emoji = emoji_fixture()
    {:ok, conn: conn, emoji: emoji}
  end

  describe "new guess" do
    test "adds emoji to assigns", %{conn: conn, emoji: emoji} do
      conn = get(conn, emoji_guess_path(conn, :new, emoji))
      assert emoji == conn.assigns.emoji
    end

    test "renders form", %{conn: conn, emoji: emoji} do
      conn = get(conn, emoji_guess_path(conn, :new, emoji))
      assert html_response(conn, 200) =~ "New Guess"
    end
  end

  describe "create guess" do
    test "adds emoji_id to params", %{conn: conn, emoji: emoji} do
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: %{})
      assert %{"emoji_id" => emoji_id} = conn.params["guess"]
      assert emoji_id == emoji.id
    end

    test "redirects to new when data is valid", %{conn: conn, emoji: emoji} do
      valid_attrs = %{content: "Star Wars"}
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: valid_attrs)
      assert redirected_to(conn) == emoji_guess_path(conn, :new, emoji)
    end

    test "renders errors when data is invalid", %{conn: conn, emoji: emoji} do
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: guess_invalid_attrs())
      assert html_response(conn, 200) =~ "New Guess"
    end
  end
end
