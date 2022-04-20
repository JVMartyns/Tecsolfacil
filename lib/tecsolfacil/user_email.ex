defmodule Tecsolfacil.UserEmail do
  @moduledoc false

  import Swoosh.Email

  def notify(user) do
    message = """
    Hello #{user.name}
    CSV file is ready.
    Download the attachment below
    """

    new()
    |> to({user.name, user.email})
    |> from({"Dr B Banner", "hulk.smash@example.com"})
    |> subject("Hello, Avengers!")
    |> text_body(message)
    |> attachment("addresses.csv")
  end
end
