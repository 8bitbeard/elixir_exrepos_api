defmodule Exrepos.Repos.Search do
  alias Exrepos.Error

  def call(username) do
    case client().get_user_repos(username) do
      {:ok, repos} -> {:ok, repos}
      {:error, %Error{}} = error -> error
    end
  end

  defp client do
    Application.fetch_env!(:exrepos, __MODULE__)[:github_adapter]
  end
end
