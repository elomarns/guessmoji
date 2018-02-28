alias Guessmoji.Repo
alias Guessmoji.Media.Language

Language.changeset(%Language{}, %{name: "English"})
|> Repo.insert!()
