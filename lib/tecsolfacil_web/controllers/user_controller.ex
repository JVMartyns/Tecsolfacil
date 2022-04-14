defmodule TecsolfacilWeb.UserController do
  use TecsolfacilWeb, :controller

  alias Tecsolfacil.Accounts

  action_fallback TecsolfacilWeb.FallbackController

  def login(conn, %{"user" => user_data}) do
    %{"email" => email, "password" => password} = user_data

    user = Accounts.get_user!(email)

    if user == nil do
      {:error, :unauthorized}
    else
      if user.password == password do
        {:ok, token, _claims} =
          Tecsolfacil.Guardian.encode_and_sign(user, %{typ: "access"}, ttl: {1, :hour})

        conn
        |> put_status(:ok)
        |> render("token.json", %{token: token})
      else
        {:error, :unauthorized}
      end
    end
  end

  def create(conn, %{"user" => user_params}) do
    IO.inspect(user_params)
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        render(conn, "show.json", user: user)

      {:error, reason} ->
        {:error, reason}
    end
  end
end
