# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :masterminds,
  ecto_repos: [Masterminds.Repo]

# Configures the endpoint
config :masterminds, MastermindsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "guhkliWFWAA2b0orCS8tt4gWXgVuYxFzmFmbxfh/lI4j4CVJwMRotXPzb0NWogaR",
  render_errors: [view: MastermindsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Masterminds.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Ueberauth
config :ueberauth, Ueberauth,
  providers: [
    auth0: { Ueberauth.Strategy.Auth0, [] },
  ]

# Configures Ueberauth's Auth0 auth provider
config :ueberauth, Ueberauth.Strategy.Auth0.OAuth,
  domain: System.get_env("AUTH0_DOMAIN"),
  client_id: System.get_env("AUTH0_CLIENT_ID"),
  client_secret: System.get_env("AUTH0_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
