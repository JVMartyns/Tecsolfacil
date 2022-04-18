defmodule Tecsolfacil.Accounts.UserTest do
  use Tecsolfacil.DataCase

  alias Tecsolfacil.Accounts.User

  @valid_attrs %{name: "JVMartyns", email: "jv@example.com", password: "test_password"}
  @invalid_attrs %{}

  describe "User Schema" do
    test "changeset with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
