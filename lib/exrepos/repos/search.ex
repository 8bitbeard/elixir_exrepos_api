defmodule Exrepos.Repos.Search do
  alias Exrepos.Error
  alias Exrepos.Github.Client

  def call(username) do
    case Client.get_user_repos(username) do
      {:ok, repos} -> {:ok, repos}
      {:error, %Error{}} = error -> error
    end
  end
end
