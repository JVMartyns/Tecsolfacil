defmodule TecsolfacilWeb.UserViewTest do
  use TecsolfacilWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  @user %{name: "user.name", email: "user.email"}

  test "renders show.json" do
    assert render(TecsolfacilWeb.UserView, "show.json", %{user: @user}) ==
      %{data: %{email: "user.email", name: "user.name"}}
  end

  test "renders user.json" do
    assert render(TecsolfacilWeb.UserView, "show.json", %{user: @user}) ==
      %{data: %{email: "user.email", name: "user.name"}}
  end

  test "renders token.json" do
    token = "Imagine tokens"
    assert render(TecsolfacilWeb.UserView, "token.json", %{token: token}) ==
      %{token: token}
  end

  test "renders created.json" do
    assert %{data: _data, status: "created"} =
      render(TecsolfacilWeb.UserView, "created.json", %{user: @user})
  end

  test "renders updated.json" do
    assert %{data: _data, status: "updated"} =
      render(TecsolfacilWeb.UserView, "updated.json", %{user: @user})
  end

  test "renders deleted.json" do
    assert %{data: _data, status: "deleted"} =
      render(TecsolfacilWeb.UserView, "deleted.json", %{user: @user})
  end
end
