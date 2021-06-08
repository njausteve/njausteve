defmodule Njausteve.Repo.Migrations.AddAuthorsToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :author_id, references(:authors, on_delete: :delete_all)
    end
  end
end
