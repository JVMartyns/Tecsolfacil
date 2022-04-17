defmodule TecsolfacilWeb.UserController do
  use TecsolfacilWeb, :controller

  import Plug.Conn

  alias Bcrypt
  alias Tecsolfacil.Accounts
  alias Tecsolfacil.Guardian

  action_fallback TecsolfacilWeb.FallbackController

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with %{password_hash: password_hash} = user <- Accounts.get_user!(email),
         true <- Bcrypt.verify_pass(password, password_hash) do
      {:ok, token, _claims} = Guardian.encode_and_sign(user, %{typ: "access"}, ttl: {1, :hour})

      conn
      |> put_status(:ok)
      |> render("token.json", %{token: token})
    else
      _ -> {:error, :unauthorized}
    end
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        render(conn, "created.json", user: user)

      {:error, reason} ->
        {:error, reason}
    end
  end

  def update(conn, %{"user" => user_params}) do
    user = get_user_by_token_in_headers(conn)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        render(conn, "updated.json", user: user)

      {:error, reason} ->
        {:error, reason}
    end
  end

  def delete(conn, _) do
    user = get_user_by_token_in_headers(conn)
    case Accounts.delete_user(user) do
    {:ok, _user} ->
      render(conn, "deleted.json", user: user)
    {:error, reason} ->
      {:error, reason}
    end
  end

  defp get_user_by_token_in_headers(conn) do
    %{"authorization" => bearer_token} = Map.new(conn.req_headers)
    [_bearer, token] = String.split(bearer_token, " ", trim: true)
    {:ok, %{"sub" => email}} = Guardian.decode_and_verify(token, %{"typ" => "access"})

    Accounts.get_user!(email)
  end
end
