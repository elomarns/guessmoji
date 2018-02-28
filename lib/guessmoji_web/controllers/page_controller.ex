defmodule GuessmojiWeb.PageController do
  use GuessmojiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
