defmodule GuessmojiWeb.LayoutView do
  use GuessmojiWeb, :view

  def alert(conn, alert_type) do
    if flash_message = get_flash(conn, alert_type) do
      content_tag(:div, class: classes_for_alert(alert_type), role: :alert) do
        raw(flash_message <> safe_to_string(close_button_for_alert()))
      end
    end
  end

  defp classes_for_alert(:info) do
    "alert alert-info alert-dismissible fade show"
  end

  defp classes_for_alert(:error) do
    "alert alert-danger alert-dismissible fade show"
  end

  defp close_button_for_alert do
    content_tag(
      :button,
      type: :button,
      class: :close,
      "data-dismiss": :alert,
      "aria-label": "Close"
    ) do
      content_tag(:span, raw("&times;"), "aria-hidden": true)
    end
  end
end
