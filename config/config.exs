# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :exrepos,
  ecto_repos: [Exrepos.Repo]

config :exrepos, Exrepos.Repos.Search, github_adapter: Exrepos.Github.Client

config :exrepos, Exrepos.Repo,
  migration_primary_key: [type: :binary_id]

config :exrepos, Exrepos.Auth.Guardian,
       issuer: "exrepos",
       secret_key: "x9Z7U7daNvdlRQwVXMqUJWpgC5g+hmD3dYDWlenlJQpvn9PFVt48tjlwVVNmJ29n"

config :exrepos, Exrepos.Auth.Pipeline,
  module: Exrepos.Auth.Guardian,
  error_handler: Exrepos.Auth.ErrorHandler

# Configures the endpoint
config :exrepos, ExreposWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ExreposWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Exrepos.PubSub,
  live_view: [signing_salt: "4GPOPr+5"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :exrepos, Exrepos.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
