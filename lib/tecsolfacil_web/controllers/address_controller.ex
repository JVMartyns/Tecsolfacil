defmodule TecsolfacilWeb.AddressController do
  use TecsolfacilWeb, :controller

  alias Tecsolfacil.Addresses
  alias Tecsolfacil.Viacep

  action_fallback TecsolfacilWeb.FallbackController

  def show(conn, %{"cep" => cep}) do
    address =
      cep
      |> insert_hyphen()
      |> Addresses.get_address!()

    case address do
      nil ->
        call_viacep(conn, cep)

      _else ->
        #call_oban(cep)
        render(conn, "show.json", address: address)
    end
  end

  defp create(conn, address_params) do
    case Addresses.create_address(address_params) do
      {:ok, address} ->
        render(conn, "show.json", address: address)

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp call_viacep(conn, cep) do
    address = Viacep.get_adress(cep)
    error = {:error, :not_found}

    if address == error do
      error
    else
      create(conn, address)
    end
  end

  defp insert_hyphen(cpf) do
    splited_cpf = String.split(cpf, "", trim: true)
    if "-" in splited_cpf or length(splited_cpf) != 8 do
      cpf
    else
      String.slice(cpf, 0..4) <> "-" <> String.slice(cpf, 5..7)
    end
  end
end
