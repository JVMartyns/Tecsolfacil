defmodule TecsolfacilWeb.AddressViewTest do
  use TecsolfacilWeb.ConnCase, async: true

  import Phoenix.View

  @address %{
    bairro: "Olaria",
    cep: "49092-717",
    complemento: "",
    ddd: "79",
    gia: "",
    ibge: "2800308",
    localidade: "Aracaju",
    logradouro: "Avenida Lourival Souza Nery",
    siafi: "3105",
    uf: "SE"
  }

  test "renders show.json" do
    assert %{data: %{cep: _cep}} =
             render(TecsolfacilWeb.AddressView, "show.json", %{address: @address})
  end

  test "renders address.json" do
    assert %{cep: _cep} = render(TecsolfacilWeb.AddressView, "address.json", %{address: @address})
  end

  test "renders csv.json" do
    assert %{message: _message} = render(TecsolfacilWeb.AddressView, "csv.json", %{})
  end
end
