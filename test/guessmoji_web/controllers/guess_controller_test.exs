defmodule GuesmojiWeb.GuessControllerTest do
  use GuessmojiWeb.ConnCase
  import GuessmojiWeb.GuessControllerHelper

  setup %{conn: conn} = config do
    conn =
      conn
      |> bypass_through(GuessmojiWeb.Router, [:browser])
      |> get("/")

    if config[:without_emojis] do
      {:ok, conn: conn}
    else
      emoji = emoji_fixture()
      {:ok, conn: conn, emoji: emoji}
    end
  end

  describe "new guess" do
    test "adds emoji to assigns", %{conn: conn, emoji: emoji} do
      conn = get(conn, emoji_guess_path(conn, :new, emoji))
      assert conn.assigns.emoji == emoji
    end

    test "renders form", %{conn: conn, emoji: emoji} do
      conn = get(conn, emoji_guess_path(conn, :new, emoji))
      assert html_response(conn, 200) =~ "Take your guess"
      assert html_response(conn, 200) =~ emoji.content
    end

    test "redirects to new guess for random emoji if there's no emoji id on params", %{
      conn: conn,
      emoji: emoji
    } do
      conn = get(conn, guess_path(conn, :new))
      assert redirected_to(conn) == emoji_guess_path(conn, :new, emoji)
    end

    @tag :without_emojis
    test "redirects to new emoji if there's no emoji", %{conn: conn} do
      conn = get(conn, guess_path(conn, :new))
      assert redirected_to(conn) == emoji_path(conn, :new)
    end
  end

  describe "create guess" do
    test "adds emoji id to params", %{conn: conn, emoji: emoji} do
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: %{})
      assert conn.params["guess"]["emoji_id"] == emoji.id
    end

    test "updates the emoji ignore list when the guess is right", %{conn: conn, emoji: emoji} do
      right_guess_attrs = %{content: "Star Wars: Episode I – The Phantom Menace"}
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: right_guess_attrs)
      assert get_session(conn, :emoji_ignore_list) == [emoji.id]
    end

    test "doesn't update the emoji ignore list when the guess is wrong", %{
      conn: conn,
      emoji: emoji
    } do
      wrong_guess_attrs = %{content: "Star Wars"}
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: wrong_guess_attrs)
      assert get_session(conn, :emoji_ignore_list) == nil
    end

    test "adds a feedback message on flash", %{conn: conn, emoji: emoji} do
      wrong_guess_attrs = %{content: "Star Trek"}
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: wrong_guess_attrs)
      assert get_flash(conn, :error) in get_wrong_guess_messages()

      right_guess_attrs = %{content: "Star Wars: Episode I – The Phantom Menace"}
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: right_guess_attrs)
      assert get_flash(conn, :info) in get_right_guess_messages()
    end

    test "renders new when the guess is wrong", %{conn: conn, emoji: emoji} do
      wrong_guess_attrs = %{content: "Lost in Space"}
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: wrong_guess_attrs)
      assert html_response(conn, 200) =~ "Take your guess"
    end

    test "redirects to new guess for random emoji when the guess is right", %{
      conn: conn,
      emoji: emoji
    } do
      another_emoji = emoji_fixture(emoji_update_attrs())

      right_guess_attrs = %{content: "Star Wars: Episode I – The Phantom Menace"}
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: right_guess_attrs)
      assert redirected_to(conn) == emoji_guess_path(conn, :new, another_emoji)
    end

    test "renders errors when data is invalid", %{conn: conn, emoji: emoji} do
      conn = post(conn, emoji_guess_path(conn, :create, emoji), guess: guess_invalid_attrs())
      assert html_response(conn, 200) =~ "Take your guess"
      assert html_response(conn, 200) =~ "<div class=\"invalid-feedback\">"
    end
  end
end
