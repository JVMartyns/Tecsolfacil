defmodule TecsolfacilWeb.AddressControllerTest do
  use TecsolfacilWeb.ConnCase

  describe "AddressController" do
    @user_params %{
      "name" => "jvmartyns",
      "email" => "jv@email.com",
      "password" => "fake_password"
    }

    test "show/2", %{conn: conn} do
      Tecsolfacil.Accounts.create_user(@user_params)

      {:ok, token, _claims} =
        Tecsolfacil.Accounts.get_user!(@user_params["email"])
        |> Tecsolfacil.Guardian.encode_and_sign(%{typ: "access"}, ttl: {1, :hour})

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
