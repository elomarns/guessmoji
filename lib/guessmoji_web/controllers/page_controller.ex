defmodule GuessmojiWeb.PageController do
  use GuessmojiWeb, :controller

  def home(conn, _opts) do
    render(conn, "home.html")
  end
end
