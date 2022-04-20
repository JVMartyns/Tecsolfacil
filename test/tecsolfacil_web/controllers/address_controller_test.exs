defmodule TecsolfacilWeb.AddressControllerTest do
  use TecsolfacilWeb.ConnCase

  import Mox

  setup :verify_on_exit!

  @user_params %{
    "name" => "jvmartyns",
    "email" => "jv@email.com",
    "password" => "fake_password"
  }

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

  describe "AddressController" do
    test "show/2", %{conn: conn} do
      Tecsolfacil.Accounts.create_user(@user_params)

      {:ok, token, _claims} =
        Tecsolfacil.Accounts.get_user!(@user_params["email"])
        |> Tecsolfacil.Guardian.encode_and_sign(%{typ: "access"}, ttl: {1, :hour})

      Tecsolfacil.MockCepClient
      |> expect(:get_address, fn _cep -> @address end)

      conn =
        conn
        |> put_req_header("authorization", "bearer #{token}")
        |> get(Routes.api_address_path(conn, :show, "72210-261"))

      assert %{"data" => %{"cep" => _cep}} = json_response(conn, 200)
    end

    test "show/2 without a valid token", %{conn: conn} do
      conn = get(conn, Routes.api_address_path(conn, :show, "72210-261"))

      assert %{"errors" => %{"detail" => "Unauthorized"}} = json_response(conn, 401)
    end

    test "make/2", %{conn: conn} do
      Tecsolfacil.Accounts.create_user(@user_params)

      {:ok, token, _claims} =
        Tecsolfacil.Accounts.get_user!(@user_params["email"])
        |> Tecsolfacil.Guardian.encode_and_sign(%{typ: "access"}, ttl: {1, :hour})

      conn =
        conn
        |> put_req_header("authorization", "bearer #{token}")
        |> get(Routes.api_address_path(conn, :make))

      assert %{"message" => _mesage} = json_response(conn, 200)
    end

    test "make/2 without a valid token", %{conn: conn} do
      conn = get(conn, Routes.api_address_path(conn, :make))

      assert %{"errors" => %{"detail" => "Unauthorized"}} = json_response(conn, 401)
    end
  end
end
