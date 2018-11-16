# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :enzymic_stats,
  ecto_repos: [EnzymicStats.Repo, EnzymicStats.AppRepo]

# Configures the endpoint
config :enzymic_stats, EnzymicStatsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0lQ0xg/aX32aMCxJSbpBKLhgXkMm6Cl/PU69itm9r0aUAuM/p4+GUQYI2RoQLrQi",
  render_errors: [view: EnzymicStatsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EnzymicStats.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
