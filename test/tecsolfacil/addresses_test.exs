defmodule Tecsolfacil.AddressesTest do
  use Tecsolfacil.DataCase

  alias Tecsolfacil.Addresses
  alias Tecsolfacil.Addresses.Address
  alias Tecsolfacil.Repo

  @address %{
    "cep" => "55157-675",
    "logradouro" => "Rua Amália Monteiro da SilvaLot Novo Jardim",
    "complemento" => "",
    "bairro" => "Pontilhão",
    "localidade" => "Belo Jardim",
    "uf" => "PE",
    "ibge" => "2601706",
    "gia" => "",
    "ddd" => "81",
    "siafi" => "2333"
    }

  describe "Addresses" do
    test "create_address/1" do
      Addresses.create_address(@address)

      assert [address] = Repo.all(Address)
      assert address.cep == "55157-675"
    end

    test "get_address!/1" do
      Addresses.create_address(@address)
      cep = "55157-675"
      address = Addresses.get_address!(cep)

      assert address.cep == cep
    end
  end
end
