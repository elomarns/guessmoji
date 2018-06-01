defmodule GuessmojiWeb.GuessView do
  use GuessmojiWeb, :view

  def show_emoji_tip_url(current_action) do
    current_action <> "#show-tip"
  end
end
