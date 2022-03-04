defmodule ExreposWeb.ReposView do
  use ExreposWeb, :view

  def render("search.json", %{repos: repos}), do: %{repos: repos}
end
