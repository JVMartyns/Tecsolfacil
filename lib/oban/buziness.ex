defmodule Tecsolfacil.Business do
  @moduledoc false
  use Oban.Worker,
    queue: :events,
    priority: 3,
    max_attempts: 3,
    tags: ["business"],
    unique: [period: 30]

  alias Tecsolfacil.CsvMaker

  @impl Oban.Worker
  def perform(%Oban.Job{}) do
    CsvMaker.make()

  end
end
