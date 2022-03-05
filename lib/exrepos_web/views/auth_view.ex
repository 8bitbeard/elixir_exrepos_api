defmodule ExreposWeb.AuthView do
  use ExreposWeb, :view

  def render("login.json", %{token: token}), do: %{token: token}
end
