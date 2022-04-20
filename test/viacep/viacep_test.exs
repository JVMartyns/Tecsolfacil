defmodule Tecsolfacil.ViacepTest do
  use TecsolfacilWeb.ConnCase, async: true

  describe "Viacep" do
    @tag :skip
    test "get_address/2" do
      assert {:ok, %{"cep" => cep}} = Tecsolfacil.Viacep.get_address("49085-213")
      assert cep == "49085-213"
    end

    @tag :skip
    test "get_address/2 with invalid cep" do
      assert {:error, :not_found} = Tecsolfacil.Viacep.get_address("00000-000")
    end
  end
end
