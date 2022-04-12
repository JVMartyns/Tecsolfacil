defmodule TecsolfacilWeb.AddressView do
  use TecsolfacilWeb, :view
  alias TecsolfacilWeb.AddressView

  def render("show.json", %{address: address}) do
    %{data: render_one(address, AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{
      cep: address.cep,
      logradouro: address.logradouro,
      complemento: address.complemento,
      bairro: address.bairro,
      localidade: address.localidade,
      uf: address.uf,
      ibge: address.ibge,
      gia: address.gia,
      ddd: address.ddd,
      siafi: address.siafi
    }
  end
end
