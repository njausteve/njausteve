defmodule Njausteve.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :slug, :string
      add :meta_title, :string
      add :body, :text
      add :summary, :text
      add :publishing_status, :string
      add :views, :integer

      timestamps()
    end
  end
end
