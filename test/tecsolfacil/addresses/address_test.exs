defmodule Tecsolfacil.Addresses.AddressTest do
  use Tecsolfacil.DataCase

  alias Tecsolfacil.Addresses.Address

  @valid_attrs %{
    "bairro" => "Olaria",
    "cep" => "49092-717",
    "complemento" => "",
    "ddd" => "79",
    "gia" => "",
    "ibge" => "2800308",
    "localidade" => "Aracaju",
    "logradouro" => "Avenida Lourival Souza Nery",
    "siafi" => "3105",
    "uf" => "SE"
  }

  @invalid_attrs %{}

  describe "Address Schema" do
    test "changeset with valid attributes" do
      changeset = Address.changeset(%Address{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Address.changeset(%Address{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
