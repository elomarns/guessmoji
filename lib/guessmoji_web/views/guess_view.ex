defmodule GuessmojiWeb.GuessView do
  use GuessmojiWeb, :view
  import GuessmojiWeb.LayoutView, only: [current_url: 1]

  def show_emoji_tip_url(current_action) do
    current_action <> "#show-tip"
  end
end
