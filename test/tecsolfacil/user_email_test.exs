defmodule Tecsolfacil.UserEmailTest do
  use Tecsolfacil.DataCase

  test "notify/1" do
    attrs = %{
      "name" => "JVMartyns",
      "email" => "jvmartyns@email.com",
      "password" => "example_password"
    }

    Tecsolfacil.Accounts.create_user(attrs)

    user = Tecsolfacil.Accounts.get_user!(attrs["email"])

    assert %{attachments: [%{filename: "addresses.csv"}]} = Tecsolfacil.UserEmail.notify(user)
  end
end
