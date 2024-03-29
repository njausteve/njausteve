use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :njausteve, Njausteve.Repo,
  username: "postgres",
  password: "postgres",
  database: "njausteve_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("DB_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :njausteve, NjausteveWeb.Endpoint,
  http: [port: 4002],
  server: false,
  https: [
    port: 4001,
    cipher_suite: :strong
  ]

# Print only warnings and errors during test
config :logger, level: :warn
