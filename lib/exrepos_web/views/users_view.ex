defmodule ExreposWeb.UsersView do
  use ExreposWeb, :view

  def render("create.json", %{user: user}) do
    %{
      message: "User created!",
      user: user
    }
  end
end
