alias Guessmoji.Repo
alias Guessmoji.Media.Language
alias Guessmoji.Media.Category

Language.changeset(%Language{}, %{name: "English"})
|> Repo.insert!()

Category.changeset(%Category{}, %{name: "Movies"})
|> Repo.insert!()
