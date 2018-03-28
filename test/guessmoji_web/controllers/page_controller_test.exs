defmodule GuessmojiWeb.PageControllerTest do
  use GuessmojiWeb.ConnCase

  describe "home" do
    test "renders the home page", %{conn: conn} do
      conn = get(conn, page_path(conn, :home))
      assert html_response(conn, 200) =~ "Guess the movie from the emoji!"
    end
  end
end
