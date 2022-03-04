defmodule Exrepos do
  alias Exrepos.Repos.Search, as: ReposSearch

  defdelegate get_repos(params), to: ReposSearch, as: :call
end
