defmodule Tecsolfacil.Addresses do
  @moduledoc """
  The Addresses context.
  """

  import Ecto.Query, warn: false
  alias Tecsolfacil.Addresses.Address
  alias Tecsolfacil.Repo

  def get_address!(cep), do: Repo.get_by(Address, cep: cep)

  def create_address(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end
end
