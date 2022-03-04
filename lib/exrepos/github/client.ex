defmodule Exrepos.Github.Client do
  use Tesla

  alias Exrepos.Error
  alias Exrepos.Github.{Behaviour, Response}
  alias Tesla.Env

  @behaviour Behaviour

  plug Tesla.Middleware.Headers, [{"User-Agent", "ExreposAPI"}]
  plug Tesla.Middleware.JSON

  @base_url "https://api.github.com/users/"

  def get_user_repos(url \\ @base_url, username) do
    "#{url}#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 404}}) do
    {:error, Error.build(:not_found, "User not found!")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    repos_list =
      body
      |> Enum.map(fn repo -> Response.build(repo) end)

    {:ok, repos_list}
  end
end
