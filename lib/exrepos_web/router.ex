defmodule ExreposWeb.Router do
  use ExreposWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Exrepos.Auth.Pipeline

  end

  scope "/api", ExreposWeb do
    pipe_through [:api, :auth]

    get "/repos/:username", ReposController, :search
  end

  scope "/api", ExreposWeb do
    pipe_through :api

    post "/users", UsersController, :create

    post "/auth/login", AuthController, :login
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    # coveralls-ignore-start
    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ExreposWeb.Telemetry
    end

    # coveralls-ignore-end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
