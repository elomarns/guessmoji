defmodule Guessmoji.ChangesetChangesTrimmer do
  import Ecto.Changeset

  def trim(%Ecto.Changeset{} = changeset, field) do
    if field_new_value = get_change(changeset, field) do
      put_change(changeset, field, do_trim(field_new_value))
    else
      changeset
    end
  end

  defp do_trim(string) when is_binary(string) do
    string
    |> String.trim()
    |> String.replace(~r/\s+/, " ")
  end

  defp do_trim(data), do: data
end
