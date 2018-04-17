defmodule GuesmojiWeb.GuessControllerHelperTest do
  use GuessmojiWeb.ConnCase
  import GuessmojiWeb.GuessControllerHelper
  alias Guessmoji.Media.Emoji
  alias Guessmoji.Media.Guess

  setup %{conn: conn} = config do
    emoji = emoji_fixture()

    conn =
      conn
      |> bypass_through(GuessmojiWeb.Router, [:browser])
      |> get("/")

    conn =
      if config[:with_params] do
        Phoenix.ConnTest.build_conn(:get, "/", %{"emoji_id" => emoji.id, "guess" => %{}})
      else
        conn
      end

    {:ok, conn: conn, emoji: emoji}
  end

  describe "add_emoji_to_assigns" do
    @tag :with_params
    test "adds emoji with id on params to assigns", %{conn: conn, emoji: emoji} do
      conn = add_emoji_to_assigns(conn, %{})
      assert conn.assigns.emoji == emoji
    end

    test "adds random emoji on assigns if there's no emoji id on params", %{conn: conn} do
      conn = add_emoji_to_assigns(conn, %{})
      assert %Emoji{} = conn.assigns.emoji
    end

    test "adds random emoji on assigns considering the emojis ids to ignore", %{
      conn: conn,
      emoji: emoji
    } do
      conn = put_session(conn, :emojis_ids_to_ignore, [emoji.id])
      conn = add_emoji_to_assigns(conn, %{})
      assert conn.assigns.emoji == nil

      conn = put_session(conn, :emojis_ids_to_ignore, nil)
      conn = add_emoji_to_assigns(conn, %{})
      assert conn.assigns.emoji == emoji
    end
  end

  describe "redirect_to_new_emoji_if_there_is_no_emoji" do
    test "redirects to new emoji if there's no emoji on assigns", %{conn: conn} do
      conn = assign(conn, :emoji, nil)
      conn = redirect_to_new_emoji_if_there_is_no_emoji(conn, %{})
      assert redirected_to(conn) == emoji_path(conn, :new)
    end

    test "don't redirects to new emoji if there's an emoji on assigns", %{
      conn: conn,
      emoji: emoji
    } do
      conn = assign(conn, :emoji, emoji)
      updated_conn = redirect_to_new_emoji_if_there_is_no_emoji(conn, %{})
      assert conn == updated_conn
    end
  end

  describe "add_emoji_id_to_params" do
    @tag :with_params
    test "adds emoji id on params", %{conn: conn, emoji: emoji} do
      conn = assign(conn, :emoji, emoji)
      conn = add_emoji_id_to_params(conn, %{})
      assert conn.params["guess"]["emoji_id"] == emoji.id
    end
  end

  describe "ignore_emoji" do
    test "adds the emoji id on the list of emojis ids to ignore", %{conn: conn} do
      conn = ignore_emoji(conn, 1)
      assert get_session(conn, :emojis_ids_to_ignore) == [1]
    end
  end

  describe "put_flash_for_guess" do
    test "puts info flash if the guess is correct", %{conn: conn} do
      conn = put_flash_for_guess(conn, %Guess{correct: true})
      assert get_flash(conn, :info) in get_right_guess_messages()
      refute get_flash(conn, :error)
    end

    test "puts error flash if the guess is wrong", %{conn: conn} do
      conn = put_flash_for_guess(conn, %Guess{correct: false})
      assert get_flash(conn, :error) in get_wrong_guess_messages()
      refute get_flash(conn, :info)
    end
  end

  describe "render_new_or_redirect_for_guess" do
    test "redirects to new if guess is correct", %{conn: conn} do
      conn = render_new_or_redirect_for_guess(conn, %Guess{correct: true})
      assert redirected_to(conn) == guess_path(conn, :new)
    end

    test "renders new if guess is wrong", %{conn: conn, emoji: emoji} do
      conn = assign(conn, :emoji, emoji)
      conn = Phoenix.Controller.put_view(conn, GuessmojiWeb.GuessView)
      conn = render_new_or_redirect_for_guess(conn, %Guess{correct: false})

      assert conn.resp_body =~ "Take your guess"
      assert conn.resp_body =~ emoji.content
    end
  end
end
