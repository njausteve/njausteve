defmodule Njausteve.Repo.Migrations.CreatePostsTags do
  use Ecto.Migration

  def change do
    create table(:posts_tags) do
      add :post_id, :integer
      add :tag_id, :integer

      timestamps()
    end

    create unique_index(:posts_tags, [:post_id, :tag_id])
  end
end
