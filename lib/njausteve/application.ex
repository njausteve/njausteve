defmodule Njausteve.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # sentry capture all error messages that the Plug
    # handler might not
    Logger.add_backend(Sentry.LoggerBackend)

    children = [
      # Start the Ecto repository
      Njausteve.Repo,
      # Start the Telemetry supervisor
      NjausteveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Njausteve.PubSub},
      # Start the Endpoint (http/https)
      {SiteEncrypt.Phoenix, NjausteveWeb.Endpoint},
      # Start a worker by calling: Njausteve.Worker.start_link(arg)
      # {Njausteve.Worker, arg}
      # persistent cache store for pow
      Pow.Store.Backend.MnesiaCache
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Njausteve.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NjausteveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
