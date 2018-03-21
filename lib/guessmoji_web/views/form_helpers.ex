defmodule GuessmojiWeb.FormHelpers do
  use Phoenix.HTML
  alias Ecto.Changeset

  def text_input_with_errors(%Changeset{} = changeset, form, field, opts \\ []) do
    text_input(
      form,
      field,
      Keyword.merge(opts, class: input_classes(changeset, field))
    )
  end

  def textarea_with_errors(%Changeset{} = changeset, form, field, opts \\ []) do
    textarea(
      form,
      field,
      Keyword.merge(opts, class: input_classes(changeset, field))
    )
  end

  defp input_classes(%Changeset{action: nil}, _field) do
    "form-control"
  end

  defp input_classes(%Changeset{} = changeset, field) do
    Keyword.get(changeset.errors, field)
    |> classes_for_input_with_errors()
  end

  defp classes_for_input_with_errors(nil) do
    "form-control"
  end

  defp classes_for_input_with_errors(_errors) do
    "form-control is-invalid"
  end
end
