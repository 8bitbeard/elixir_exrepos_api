defmodule ExreposWeb.UsersController do
  use ExreposWeb, :controller

  alias Exrepos.User
  alias ExreposWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Exrepos.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
