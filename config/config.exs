# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :njausteve,
  ecto_repos: [Njausteve.Repo]

# Configures the endpoint
config :njausteve, NjausteveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "E6+Xl+WV5dJ5mjYxIPVT4Kq+umJ4ptsSSG3W/TUJKE3Ec/FnMCpHm6wsFlZbsJSY",
  render_errors: [view: NjausteveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Njausteve.PubSub,
  live_view: [signing_salt: "uoBMdOyv"]

config :njausteve, :pow,
  user: Njausteve.Users.User,
  repo: Njausteve.Repo

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
