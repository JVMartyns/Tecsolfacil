defmodule Tecsolfacil.AccountsTest do
  use Tecsolfacil.DataCase

  alias Tecsolfacil.Accounts
  alias Tecsolfacil.Accounts.User
  alias Bcrypt
  alias Tecsolfacil.Repo

  @user %{
    "name" => "JVMartyns",
    "email" => "jvmartyns@email.com",
    "password" => "password 1"
  }

  @updated_user %{
    "name" => "JVMartyns",
    "email" => "jvmartyns@email.com",
    "password" => "password 2"
  }

  describe "Accounts" do
    test "create_user!/1" do
      Accounts.create_user(@user)

      assert [user] = Repo.all(User)
      assert user.email == "jvmartyns@email.com"
    end

    test "get_user!/1" do
      Accounts.create_user(@user)
      email = "jvmartyns@email.com"
      user = Accounts.get_user!(email)

      assert user.email == email
    end

    test "update_user/2" do
      {:ok, old_user} = Accounts.create_user(@user)
      Accounts.update_user(old_user, @updated_user)

      email = "jvmartyns@email.com"
      user = Accounts.get_user!(email)

      assert Bcrypt.verify_pass(@updated_user["password"], user.password_hash)
    end

    test "delete_user/2" do
      Accounts.create_user(@user)
      email = "jvmartyns@email.com"

      user = Accounts.get_user!(email)

      assert {:ok, _user} = Accounts.delete_user(user)
    end
  end
end
