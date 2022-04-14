defmodule Tecsolfacil.UserEmail do
  import Swoosh.Email

  def notify(user) do
    message = """
    Hello #{user.name}
    Arquivo CSV está pronto.
    Faça o download através do anexo abaixo
    """

    new()
    |> to({user.name, user.email})
    |> from({"Dr B Banner", "hulk.smash@example.com"})
    |> subject("Hello, Avengers!")
    |> text_body(message)
    |> attachment("addresses.csv")
  end
end
