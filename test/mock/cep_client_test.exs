defmodule Tecsolfacil.CepClientTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  @address {:ok,
  %{
    "bairro" => "Ceilândia Norte (Ceilândia)",
    "cep" => "72210-261",
    "complemento" => "",
    "ddd" => "61",
    "gia" => "",
    "ibge" => "5300108",
    "localidade" => "Brasília",
    "logradouro" => "QNM 26 Conjunto A",
    "siafi" => "9701",
    "uf" => "DF"
  }}

  describe "CepClient" do
    test "get_address" do
      Tecsolfacil.MockCepClient
      |> expect(:get_address, fn _cep -> @address end)

      assert Tecsolfacil.CepClient.get_address("72210-261") == @address
    end

    test "get_address with invalid cep" do
      Tecsolfacil.MockCepClient
      |> expect(:get_address, fn _cep -> {:error, :not_found} end)

      assert Tecsolfacil.CepClient.get_address("00000-000") == {:error, :not_found}
    end
  end
end
