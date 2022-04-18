defmodule Tecsolfacil.ViacepTest do
  use TecsolfacilWeb.ConnCase

  test "get_address/2" do
    assert {:ok, %{"cep" => cep}} = Tecsolfacil.Viacep.get_adress("49085-213")
    assert cep == "49085-213"
  end

  test "get_address/2 with invalid cep" do
    assert {:error, :not_found} = Tecsolfacil.Viacep.get_adress("00000-000")
  end
end
