defmodule ExreposWeb.FallbackController do
  use ExreposWeb, :controller

  alias Exrepos.Error
  alias ExreposWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
