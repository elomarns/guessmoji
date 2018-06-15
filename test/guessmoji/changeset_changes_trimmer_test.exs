defmodule Guessmoji.ChangesetChangesTrimmerTest do
  use Guessmoji.DataCase, async: true
  import Guessmoji.ChangesetChangesTrimmer
  alias Guessmoji.Media.Language

  test "trim/2 removes all leading and trailing whitespace on changed field" do
    changeset =
      Ecto.Changeset.cast(%Language{}, %{name: "  Portuguese  "}, [:name])
      |> trim(:name)

    name = get_change(changeset, :name)
    assert name == "Portuguese"
  end

  test "trim/2 replaces multiple whitespaces for just one" do
    changeset =
      Ecto.Changeset.cast(%Language{}, %{name: "Brazilian  Portuguese"}, [:name])
      |> trim(:name)

    name = get_change(changeset, :name)
    assert name == "Brazilian Portuguese"
  end
end
