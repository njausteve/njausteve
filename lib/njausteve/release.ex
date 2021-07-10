defmodule Njausteve.Release do
  @moduledoc """
    Release task to execute custom commands required to set up the production environment
    Since we don't have Mix, a build tool, inside releases, which are a production artifact,
    we need to bring said commands directly into the release
  """
  @app :njausteve

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
