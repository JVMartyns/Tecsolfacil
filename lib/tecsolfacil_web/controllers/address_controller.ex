defmodule TecsolfacilWeb.AddressController do
  use TecsolfacilWeb, :controller

  alias Tecsolfacil.Addresses
  alias Tecsolfacil.Viacep

  import Plug.Conn

  action_fallback TecsolfacilWeb.FallbackController

  def show(conn, %{"cep" => cep}) do
    case address = Addresses.get_address!(insert_hyphen(cep)) do
      nil ->
        call_viacep(conn, cep)

      _else ->
        render(conn, "show.json", address: address)
    end
  end

  def make(conn, _) do
    %{"authorization" => token} = Map.new(conn.req_headers)

    %{token: token}
    |> Tecsolfacil.Business.new()
    |> Oban.insert()

    render(conn, "csv.json")
  end

  defp insert_hyphen(cep) do
    splited_cep = String.split(cep, "", trim: true)

    if "-" in splited_cep or length(splited_cep) != 8 do
      cep
    else
      String.slice(cep, 0..4) <> "-" <> String.slice(cep, 5..7)
    end
  end

  defp call_viacep(conn, cep) do
    case Viacep.get_adress(cep) do
      {:ok, address} ->
        create(conn, address)

      _else ->
        {:error, :not_found}
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
end
