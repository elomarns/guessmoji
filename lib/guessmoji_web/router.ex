defmodule GuessmojiWeb.Router do
  use GuessmojiWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", GuessmojiWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", EmojiController, :new)
    resources("/emojis", EmojiController, only: [:new, :create])
  end

  # Other scopes may use custom stacks.
  # scope "/api", GuessmojiWeb do
  #   pipe_through :api
  # end
end
