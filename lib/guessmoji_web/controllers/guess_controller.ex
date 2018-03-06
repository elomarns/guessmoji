defmodule GuessmojiWeb.GuessController do
  use GuessmojiWeb, :controller

  alias Plug.Conn
  alias Guessmoji.Media
  alias Guessmoji.Media.Guess

  plug(:add_emoji_to_assigns when action in [:new, :create])
  plug(:redirect_to_new_emoji_if_there_is_no_emoji)
  plug(:add_emoji_id_to_params when action in [:create])

  def new(conn, _params) do
    changeset = Media.change_guess(%Guess{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"guess" => guess_params}) do
    case Media.create_guess(guess_params) do
      {:ok, guess} ->
        conn
        |> put_flash(:info, guess_feedback(guess))
        |> redirect(to: emoji_guess_path(conn, :new, conn.assigns.emoji))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp guess_feedback(%Guess{correct: true}), do: "Your guess is right!"
  defp guess_feedback(%Guess{correct: false}), do: "Your guess is wrong!"

  defp add_emoji_to_assigns(%Conn{params: %{"emoji_id" => emoji_id}} = conn, _opts) do
    emoji = Media.get_emoji!(emoji_id)
    assign(conn, :emoji, emoji)
  end

  defp add_emoji_to_assigns(conn, _opts) do
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

  defp add_emoji_id_to_params(conn, _opts) do
    put_in(
      conn.params["guess"]["emoji_id"],
      conn.assigns.emoji.id
    )
  end
end
