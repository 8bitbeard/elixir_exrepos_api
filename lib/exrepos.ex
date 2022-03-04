defmodule Exrepos do
  alias Exrepos.Repos.Search, as: ReposSearch
  alias Exrepos.Users.Create, as: UsersCreate

  defdelegate get_repos(params), to: ReposSearch, as: :call
  defdelegate create_user(params), to: UsersCreate, as: :call
end
