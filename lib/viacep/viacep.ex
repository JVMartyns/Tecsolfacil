defmodule Tecsolfacil.Viacep do
  @moduledoc """
  This module searches for a zip code in the Viacep API. If not found, returns an error.
  """

  require Logger

  def get_adress(cep \\ "") do
    viacep_url = "https://viacep.com.br/ws/#{cep}/json/"

    {:ok, response} =
      :get
      |> Finch.build(viacep_url)
      |> Finch.request(MyFinch)

    case Jason.decode(response.body) do
      {:ok, %{"cep" => _cep} = address} ->
        {:ok, address}

      _else ->
        {:error, :not_found}
    end
  end
end
