defmodule GuessmojiWeb.GuessView do
  use GuessmojiWeb, :view

  def guess_content_label(emoji) do
    "What movie #{emoji.content} represents?"
  end
end
