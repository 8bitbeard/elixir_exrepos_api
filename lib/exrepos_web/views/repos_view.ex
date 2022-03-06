defmodule ExreposWeb.ReposView do
  use ExreposWeb, :view

  def render("search.json", %{repos: repos, refresh_token: refresh_token}) do
    %{
      repos: repos,
      refresh_token: refresh_token
    }
  end
end
