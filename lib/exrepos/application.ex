defmodule Exrepos.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Exrepos.Repo,
      # Start the Telemetry supervisor
      ExreposWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Exrepos.PubSub},
      # Start the Endpoint (http/https)
      ExreposWeb.Endpoint
      # Start a worker by calling: Exrepos.Worker.start_link(arg)
      # {Exrepos.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exrepos.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExreposWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
