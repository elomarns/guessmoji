defmodule Guessmoji.ChangesetChangesTrimmer do
  import Ecto.Changeset

  def trim(%Ecto.Changeset{} = changeset, field) do
    field_value =
      get_change(changeset, field)
      |> to_string()

    put_change(changeset, field, String.trim(field_value))
  end
end
