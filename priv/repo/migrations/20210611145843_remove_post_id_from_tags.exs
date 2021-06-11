defmodule Njausteve.Repo.Migrations.RemovePostIdFromTags do
  use Ecto.Migration

  def up do
    drop index(:tags, [:post_id])

    alter table(:tags) do
      remove :post_id
    end
  end

  def down do
    alter table(:tags) do
      add :post_id, references(:posts, on_delete: :nilify_all)
    end

    create index(:tags, [:post_id])
  end
end
