defmodule ExreposWeb.AuthController do
  use ExreposWeb, :controller

  alias Exrepos.Auth.Guardian
  alias ExreposWeb.FallbackController

  action_fallback FallbackController

  def login(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("login.json", token: token)
    end
  end
end
