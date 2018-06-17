defmodule GuesmojiWeb.GuessControllerHelperTest do
  use GuessmojiWeb.ConnCase
  import GuessmojiWeb.GuessControllerHelper
  alias Guessmoji.Media
  alias Guessmoji.Media.Guess

  setup %{conn: conn} = config do
    emoji =
      if config[:with_emoji] do
        emoji_fixture()
      else
        nil
      end

    conn =
      if config[:with_params] do
        Phoenix.ConnTest.build_conn(:get, "/", %{"emoji_id" => emoji.id, "guess" => %{}})
      else
        conn
        |> bypass_through(GuessmojiWeb.Router, [:browser])
        |> get("/")
      end

    {:ok, conn: conn, emoji: emoji}
  end

  describe "add_emoji_to_assigns/2" do
    @tag :with_emoji
    @tag :with_params
    test "adds emoji with id on params to assigns", %{conn: conn} do
      conn = add_emoji_to_assigns(conn, %{})
      assert conn.assigns.emoji == Media.get_emoji!(conn.params["emoji_id"])
    end

    test "raises an error if there's no emoji with the id present on params", %{conn: conn} do
      conn = put_in(conn.params["emoji_id"], 42)

      assert_raise Ecto.NoResultsError, fn ->
        add_emoji_to_assigns(conn, %{})
      end
    end

    @tag :with_emoji
    test "redirects to new guess for random emoji if there's no emoji id on params", %{
      conn: conn,
      emoji: emoji
    } do
      conn = add_emoji_to_assigns(conn, %{})
      assert redirected_to(conn) == emoji_guess_path(conn, :new, emoji.id)
      assert conn.halted
    end

    test "redirects to new emoji if there's no emoji id on params and no emoji on database", %{
      conn: conn
    } do
      conn = add_emoji_to_assigns(conn, %{})

      assert get_flash(conn, :error) ==
               "There's no emoji available to guess. How about you create a new one?"

      assert redirected_to(conn) == emoji_path(conn, :new)
      assert conn.halted
    end

    @tag :with_emoji
    test "redirects to new emoji if there's no emoji available", %{conn: conn, emoji: emoji} do
      conn = put_session(conn, :emoji_ignore_list, [emoji.id])
      conn = add_emoji_to_assigns(conn, %{})

      assert get_flash(conn, :error) ==
               "There's no emoji available to guess. How about you create a new one?"

      assert redirected_to(conn) == emoji_path(conn, :new)
      assert conn.halted
    end
  end

  describe "add_emoji_id_to_params/2" do
    @tag :with_emoji
    test "adds on params the id of the emoji on assigns", %{conn: conn, emoji: emoji} do
      conn = assign(conn, :emoji, emoji)
      conn = put_in(conn.params["guess"], %{})
      conn = add_emoji_id_to_params(conn, %{})

      assert conn.params["guess"]["emoji_id"] == emoji.id
    end
  end

  describe "handle_emoji_ignore_list_for_guess/2" do
    test "add the emoji id if the guess is right", %{conn: conn} do
      conn = put_session(conn, :emoji_ignore_list, [])
      conn = handle_emoji_ignore_list_for_guess(conn, %Guess{emoji_id: 1, correct: true})
      assert get_session(conn, :emoji_ignore_list) == [1]
    end

    test "doesn't add the emoji id if the guess is wrong", %{conn: conn} do
      conn = put_session(conn, :emoji_ignore_list, [])
      conn = handle_emoji_ignore_list_for_guess(conn, %Guess{emoji_id: 1, correct: false})
      assert get_session(conn, :emoji_ignore_list) == []
    end
  end

  describe "put_flash_for_guess/2" do
    test "puts info on flash if the guess is correct", %{conn: conn} do
      conn = put_flash_for_guess(conn, %Guess{correct: true})
      assert get_flash(conn, :info) in get_right_guess_messages()
      refute get_flash(conn, :error)
    end

    test "puts error on flash if the guess is wrong", %{conn: conn} do
      conn = put_flash_for_guess(conn, %Guess{correct: false})
      assert get_flash(conn, :error) in get_wrong_guess_messages()
      refute get_flash(conn, :info)
    end
  end

  describe "render_new_or_redirect_for_guess/2" do
    @tag :with_emoji
    test "redirects to new if guess is correct", %{conn: conn, emoji: emoji} do
      conn = render_new_or_redirect_for_guess(conn, %Guess{correct: true})
      assert redirected_to(conn) == emoji_guess_path(conn, :new, emoji)
    end

    @tag :with_emoji
    test "renders new if guess is wrong", %{conn: conn, emoji: emoji} do
      conn = assign(conn, :emoji, emoji)
      conn = Phoenix.Controller.put_view(conn, GuessmojiWeb.GuessView)
      conn = render_new_or_redirect_for_guess(conn, %Guess{correct: false})

      assert conn.resp_body =~ "Take your guess"
      assert conn.resp_body =~ emoji.content
    end
  end
end
