defmodule TecsolfacilWeb.UserControllerTest do
  use TecsolfacilWeb.ConnCase

  import Plug.Conn

  describe "UserController" do

    @user_attrs %{
      "user" =>  %{
          "name" =>  "JVMartyns",
          "email" =>  "jvmartyns@email.com",
          "password" =>  "valid_password"
          }
      }
    @update_attrs %{
      "user" =>  %{
          "name" =>  "JVMartyns",
          "email" =>  "jvmartyns@email.com",
          "password" =>  "valid_password_updated"
          }
      }
    @invalid_attrs %{
      "user" =>  %{
          "name" =>  nil,
          "email" =>  nil,
          "password" =>  nil
          }
      }

    test "create/2", %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :create, @user_attrs))
      assert %{"status" => "created"} = json_response(conn, 200)
    end

    test "create/2 with invalid attrs", %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :create, @invalid_attrs))
      assert %{"errors" => _reason} = json_response(conn, 422)
    end

    test "login/2", %{conn: conn} do
      %{"user" => user_params} = @user_attrs
      Tecsolfacil.Accounts.create_user(user_params)
      conn = post(conn, Routes.api_user_path(conn, :login, @user_attrs))
      assert %{"token" => _token} = json_response(conn, 200)
    end

    test "login/2 with invalid attrs", %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :login, @invalid_attrs))
      assert json_response(conn, 401) == %{"errors" => %{"detail" => "Unauthorized"}}
    end

    test "update/2", %{conn: conn} do
      %{"user" => user_params} = @user_attrs
      Tecsolfacil.Accounts.create_user(user_params)

      {:ok, token, _claims} =
      Tecsolfacil.Accounts.get_user!(user_params["email"])
      |> Tecsolfacil.Guardian.encode_and_sign(%{typ: "access"}, ttl: {1, :hour})

      conn =
        conn
        |> put_req_header("authorization", "bearer #{token}")
        |> post(Routes.api_user_path(conn, :update, @update_attrs))

      assert %{"status" => "updated"} = json_response(conn, 200)
    end

    test "delete/2", %{conn: conn} do
      %{"user" => user_params} = @user_attrs
      Tecsolfacil.Accounts.create_user(user_params)

      {:ok, token, _claims} =
      Tecsolfacil.Accounts.get_user!(user_params["email"])
      |> Tecsolfacil.Guardian.encode_and_sign(%{typ: "access"}, ttl: {1, :hour})

      conn =
        conn
        |> put_req_header("authorization", "bearer #{token}")
        |> post(Routes.api_user_path(conn, :delete, @user_attrs))

      assert %{"status" => "deleted"} = json_response(conn, 200)
    end
  end
end
