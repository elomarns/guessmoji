defmodule Guessmoji.ChangesetChangesTrimmer do
  import Ecto.Changeset

  def trim(%Ecto.Changeset{} = changeset, field) do
    if field_new_value = get_change(changeset, field) do
      field_new_value = to_string(field_new_value)
      put_change(changeset, field, String.trim(field_new_value))
    else
      changeset
    end
  end
end
