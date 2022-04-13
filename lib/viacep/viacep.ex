defmodule Tecsolfacil.Viacep do
  @moduledoc """
  This module searches for a zip code in the Viacep API. If not found, returns an error.
  """

  require Logger

  def get_adress(cep) do
    viacep_url = "https://viacep.com.br/ws/#{cep}/json/"

    {:ok, address} =
      :get
      |> Finch.build(viacep_url)
      |> Finch.request(MyFinch)

    if address.status == 200 do
      {:ok, address_body} = Jason.decode(address.body)
      address_body
    else
      {:error, :not_found}
    end
  end
end
