defmodule TecsolfacilWeb.UserView do
  use TecsolfacilWeb, :view
  alias TecsolfacilWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      name: user.name,
      email: user.email
    }
  end

  def render("token.json", %{token: token}) do
    %{token: token}
  end

  def render("criated.json", %{user: user}) do
    %{
      status: "criated",
      data: render_one(user, UserView, "user.json")
    }
  end

  def render("updated.json", %{user: user}) do
    %{
      status: "updated",
      data: render_one(user, UserView, "user.json")
    }
  end

  def render("deleted.json", %{user: user}) do
    %{
      status: "deleted",
      data: render_one(user, UserView, "user.json")
    }
  end
end
