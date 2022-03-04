defmodule Exrepos.Github.Behaviour do
  alias Exrepos.Error

  @callback get_user_repos(String.t()) :: {:ok, list()} | {:error, Error.t()}
end
