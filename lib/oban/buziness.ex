defmodule Tecsolfacil.Business do
  @moduledoc false
  use Oban.Worker,
    queue: :events,
    priority: 3,
    max_attempts: 3,
    tags: ["business"],
    unique: [period: 30]

  alias Tecsolfacil.Accounts
  alias Tecsolfacil.CsvMaker
  alias Tecsolfacil.Guardian
  alias Tecsolfacil.Mailer
  alias Tecsolfacil.UserEmail

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"token" => bearer_token}}) do
    [_bearer, token] = String.split(bearer_token, " ", trim: true)
    {:ok, %{"sub" => email}} = Guardian.decode_and_verify(token, %{"typ" => "access"})
    user = Accounts.get_user!(email)

    CsvMaker.make()

    user
    |> UserEmail.notify()
    |> Mailer.deliver()

    File.rm("addresses.csv")
  end
end
