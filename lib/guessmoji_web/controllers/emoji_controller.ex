defmodule GuessmojiWeb.EmojiController do
  use GuessmojiWeb, :controller

  alias Guessmoji.Media
  alias Guessmoji.Media.Emoji

  plug(:add_default_language_id_to_params when action in [:create])
  plug(:add_default_category_id_to_params when action in [:create])

  def new(conn, _params) do
    changeset = Media.change_emoji(%Emoji{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"emoji" => emoji_params}) do
    case Media.create_emoji(emoji_params) do
      {:ok, _emoji} ->
        conn
        |> put_flash(:info, "Emoji created successfully.")
        |> redirect(to: emoji_path(conn, :new))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @default_language Application.get_env(:guessmoji, :default_language)

  defp add_default_language_id_to_params(conn, _opts) do
    put_in(
      conn.params["emoji"]["language_id"],
      Media.get_language_by!(%{name: @default_language}).id
    )
  end

  @default_category Application.get_env(:guessmoji, :default_category)

  defp add_default_category_id_to_params(conn, _opts) do
    put_in(
      conn.params["emoji"]["category_id"],
      Media.get_category_by!(%{name: @default_category}).id
    )
  end
end
