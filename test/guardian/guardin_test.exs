defmodule Tecsolfacil.GuardianTest do
  use Tecsolfacil.DataCase

  test "subject_for_token/2" do
    email = "email@example.com"
    assert Tecsolfacil.Guardian.subject_for_token(%{email: email}, []) == {:ok, email}
  end

  test "subject_for_token/2 with invalid data" do
    assert Tecsolfacil.Guardian.subject_for_token(%{}, []) == {:error, :invalid_resource}
  end

  test "resource_from_claims/1" do
    attrs = %{
      "name" => "JVMartyns",
      "email" => "jvmartyns@email.com",
      "password" => "example_password"
    }

    Tecsolfacil.Accounts.create_user(attrs)

    {:ok, _token, claims} =
      Tecsolfacil.Accounts.get_user!(attrs["email"])
      |> Tecsolfacil.Guardian.encode_and_sign()

    assert {:ok, resource} = Tecsolfacil.Guardian.resource_from_claims(claims)
  end

  test "resource_from_claims/1 with invalid token" do
    assert Tecsolfacil.Guardian.resource_from_claims(%{}) == {:error, :invalid_token}
  end
end
