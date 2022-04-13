defmodule Tecsolfacil.Business do
  @moduledoc false
  use Oban.Worker,
    queue: :events,
    priority: 3,
    max_attempts: 3,
    tags: ["business"],
    unique: [period: 30]

  # alias Tecsolfacil.Accounts
  # alias Tecsolfacil.GitHubApi
  # alias Tecsolfacil.Mailer
  # alias Tecsolfacil.UserEmail
  # alias System

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"username" => username}}) do
  end
end
