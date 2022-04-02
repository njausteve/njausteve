defmodule Njausteve.MixProject do
  use Mix.Project

  def project do
    [
      app: :njausteve,
      version: version(),
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: dialyzer(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Njausteve.Application, []},
      extra_applications: [:logger, :runtime_tools, :mnesia]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6.6"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:hackney, "~> 1.8"},
      {:plug_cowboy, "~> 2.5"},
      {:earmark, "~> 1.3.6"},

      # Testing libraries
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:ex_machina, "~> 2.7.0", only: :test},

      # code quality
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.8", only: :dev},
      {:excoveralls, "~> 0.10", only: :test},

      # Authentication
      {:pow, "~> 1.0.26"},

      # Monitoring
      {:sentry, "~> 8.0"},

      # Other Libraries
      {:floki, "~> 0.32.0"},
      {:timex, "~> 3.0"}
    ]
  end

  defp dialyzer do
    [
      plt_core_path: "priv/plts",
      plt_add_apps: [:mix, :ex_unit],
      plt_ignore_apps: [:mnesia],
      ignore_warnings: ".known_dialyzer_warnings"
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end

  # This only accepts MAJOR.MINOR scheme.
  @semantic_version "0.1"

  # Generates the app version according to the commit hash and timestamps.
  def version do
    {{year, month, day}, _time} = :calendar.universal_time()
    version = @semantic_version
    env = Mix.env() |> Atom.to_string()

    revision =
      System.cmd("git", ["rev-parse", "--short", "HEAD"]) |> elem(0) |> String.trim_trailing()

    :io_lib.format(
      '~s.~4.10.0b~2.10.0b~2.10.0b-~s+~s',
      [version, year, month, day, env, revision]
    )
    |> :erlang.list_to_binary()
  end
end
