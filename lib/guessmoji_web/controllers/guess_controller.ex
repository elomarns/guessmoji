defmodule GuessmojiWeb.GuessController do
  use GuessmojiWeb, :controller
  import GuessmojiWeb.GuessControllerHelper
  alias Guessmoji.Media
  alias Guessmoji.Media.Guess

  plug(:add_emoji_to_assigns)
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
        |> ignore_emoji(guess.emoji_id)
        |> put_flash_for_guess(guess)
        |> render_new_or_redirect_for_guess(guess)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
