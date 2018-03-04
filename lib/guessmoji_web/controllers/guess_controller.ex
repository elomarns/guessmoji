defmodule GuessmojiWeb.GuessController do
  use GuessmojiWeb, :controller

  alias Guessmoji.Media
  alias Guessmoji.Media.Guess

  plug(:add_emoji_to_assigns when action in [:new, :create])
  plug(:add_emoji_id_to_params when action in [:create])

  def new(conn, _params) do
    changeset = Media.change_guess(%Guess{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"guess" => guess_params}) do
    case Media.create_guess(guess_params) do
      {:ok, _guess} ->
        conn
        |> put_flash(:info, "Guess created successfully.")
        |> redirect(to: emoji_guess_path(conn, :new, conn.assigns.emoji))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp add_emoji_to_assigns(%Plug.Conn{params: %{"emoji_id" => emoji_id}} = conn, _opts) do
    emoji = Media.get_emoji!(emoji_id)
    assign(conn, :emoji, emoji)
  end

  defp add_emoji_to_assigns(conn, _opts) do
    emoji = Media.get_random_emoji()
    assign(conn, :emoji, emoji)
  end

  defp add_emoji_id_to_params(conn, _opts) do
    put_in(
      conn.params["guess"]["emoji_id"],
      conn.assigns.emoji.id
    )
  end
end
