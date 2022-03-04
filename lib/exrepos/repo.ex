defmodule Exrepos.Repo do
  use Ecto.Repo,
    otp_app: :exrepos,
    adapter: Ecto.Adapters.Postgres
end
