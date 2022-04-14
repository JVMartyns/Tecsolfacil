defmodule Tecsolfacil.UserEmail do
  import Swoosh.Email

  def notify(user) do
    message = """
    <h1>Hello #{user.name}</h1>
    <a href="../../test.csv" download>download</a>
    """

    new()
    |> to({user.name, user.email})
    |> from({"Dr B Banner", "hulk.smash@example.com"})
    |> subject("Hello, Avengers!")
    #|> html_body(@message)
    |> text_body(message)
  end
end
