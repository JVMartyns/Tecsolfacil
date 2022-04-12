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
end
