defmodule GuessmojiWeb.GuessControllerHelper do
  import Phoenix.Controller
  import Plug.Conn
  import GuessmojiWeb.Router.Helpers

  alias Plug.Conn
  alias Guessmoji.Media
  alias Guessmoji.Media.{Emoji, Guess}

  def add_emoji_to_assigns(%Conn{params: %{"emoji_id" => emoji_id}} = conn, _opts) do
    emoji = Media.get_emoji!(emoji_id)
    assign(conn, :emoji, emoji)
  end

  def add_emoji_to_assigns(conn, _opts) do
    redirect_to_new_guess_for_random_emoji(conn)
  end

  defp redirect_to_new_guess_for_random_emoji(conn) do
    emoji_ignore_list = get_emoji_ignore_list(conn)
    random_emoji = Media.get_random_emoji(emoji_ignore_list)
    handle_random_emoji(conn, random_emoji)
  end

  defp get_emoji_ignore_list(conn) do
    get_session(conn, :emoji_ignore_list) || []
  end

  defp handle_random_emoji(conn, %Emoji{} = random_emoji) do
    conn
    |> redirect(to: emoji_guess_path(conn, :new, random_emoji))
    |> halt()
  end

  defp handle_random_emoji(conn, nil) do
    conn
    |> put_flash(:error, "There's no emoji available to guess. How about you create a new one?")
    |> redirect(to: emoji_path(conn, :new))
    |> halt()
  end

  def add_emoji_id_to_params(conn, _opts) do
    put_in(
      conn.params["guess"]["emoji_id"],
      conn.assigns.emoji.id
    )
  end

  def handle_emoji_ignore_list_for_guess(conn, %Guess{correct: true} = guess) do
    put_session(conn, :emoji_ignore_list, get_emoji_ignore_list(conn) ++ [guess.emoji_id])
  end

  def handle_emoji_ignore_list_for_guess(conn, %Guess{correct: false} = _guess) do
    conn
  end

  def put_flash_for_guess(conn, %Guess{correct: true} = guess) do
    put_flash(conn, :info, feedback_message_for_guess(guess))
  end

  def put_flash_for_guess(conn, %Guess{correct: false} = guess) do
    put_flash(conn, :error, feedback_message_for_guess(guess))
  end

  @right_guess_messages [
    "Nailed it!",
    "You're goddamn right!",
    "Bingo!",
    "You are correct, sir!"
  ]

  def get_right_guess_messages, do: @right_guess_messages

  @wrong_guess_messages [
    "Wrong answer, my friend!",
    "This is not the answer you are looking for.",
    "Houston, we have a wrong answer."
  ]

  def get_wrong_guess_messages, do: @wrong_guess_messages

  defp feedback_message_for_guess(%Guess{correct: true}) do
    Enum.random(@right_guess_messages)
  end

  defp feedback_message_for_guess(%Guess{correct: false}) do
    Enum.random(@wrong_guess_messages)
  end

  def render_new_or_redirect_for_guess(conn, %Guess{correct: true}) do
    redirect_to_new_guess_for_random_emoji(conn)
  end

  def render_new_or_redirect_for_guess(conn, %Guess{correct: false}) do
    GuessmojiWeb.GuessController.new(conn, %{})
  end
end
