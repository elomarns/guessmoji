defmodule GuessmojiWeb.GuessControllerHelper do
  import Phoenix.Controller
  import Plug.Conn
  import GuessmojiWeb.Router.Helpers

  alias Plug.Conn
  alias Guessmoji.Media
  alias Guessmoji.Media.Guess

  def add_emoji_to_assigns(%Conn{params: %{"emoji_id" => emoji_id}} = conn, _opts) do
    emoji = Media.get_emoji!(emoji_id)
    assign(conn, :emoji, emoji)
  end

  def add_emoji_to_assigns(conn, _opts) do
    emoji = Media.get_random_emoji()
    assign(conn, :emoji, emoji)
  end

  def redirect_to_new_emoji_if_there_is_no_emoji(%Conn{assigns: %{emoji: nil}} = conn, _opts) do
    conn
    |> put_flash(:error, "There's no emoji to guess.")
    |> redirect(to: emoji_path(conn, :new))
    |> halt()
  end

  def redirect_to_new_emoji_if_there_is_no_emoji(%Conn{assigns: %{emoji: _emoji}} = conn, _opts) do
    conn
  end

  def add_emoji_id_to_params(conn, _opts) do
    put_in(
      conn.params["guess"]["emoji_id"],
      conn.assigns.emoji.id
    )
  end

  def put_flash_for_guess(conn, %Guess{correct: true}) do
    put_flash(conn, :info, "Your guess is right!")
  end

  def put_flash_for_guess(conn, %Guess{correct: false}) do
    put_flash(conn, :error, "Your guess is wrong!")
  end

  def render_new_or_redirect_for_guess(conn, %Guess{correct: true}) do
    redirect(conn, to: guess_path(conn, :new))
  end

  def render_new_or_redirect_for_guess(conn, %Guess{correct: false}) do
    GuessmojiWeb.GuessController.new(conn, %{})
  end
end
