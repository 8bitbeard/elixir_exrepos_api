defmodule ExreposWeb.ReposController do
  use ExreposWeb, :controller

  alias ExreposWeb.FallbackController

  action_fallback FallbackController

  def search(conn, %{"username" => username}) do
    with {:ok, repos} <- Exrepos.get_repos(username) do
      conn
      |> put_status(:ok)
      |> render("search.json", repos: repos)
    end
  end
end
