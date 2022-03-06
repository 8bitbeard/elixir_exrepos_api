defmodule ExreposWeb.ReposController do
  use ExreposWeb, :controller

  alias Exrepos.Auth.Guardian
  alias ExreposWeb.FallbackController

  action_fallback FallbackController

  def search(conn, %{"username" => username}) do
    token = Guardian.Plug.current_token(conn)

    with {:ok, repos} <- Exrepos.get_repos(username),
         {:ok, _old_stuff, {refresh_token, _new_claims}} = Guardian.refresh(token, ttl: {1, :minute}) do
      conn
      |> put_status(:ok)
      |> render("search.json", repos: repos, refresh_token: refresh_token)
    end
  end
end
