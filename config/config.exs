# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bambooInterview,
  ecto_repos: [BambooInterview.Repo]

# Configures the endpoint
config :bambooInterview, BambooInterviewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7U7OFYXg9L1uvu3KFYNpQNyRjTic8jyZN73/ekxYX6V4XfvLp5+EIAxAcuOZ5iJ0",
  render_errors: [view: BambooInterviewWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BambooInterview.PubSub,
  live_view: [signing_salt: "2CPqAtvE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :bambooInterview, BambooInterview.Services.Mailer,
   adapter: Bamboo.LocalAdapter

config :bambooInterview, BambooInterview.Repo, migration_primary_key: [name: :uuid, type: :binary_id]
config :bambooInterview, BambooInterview.Repo, migration_primary_key: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
