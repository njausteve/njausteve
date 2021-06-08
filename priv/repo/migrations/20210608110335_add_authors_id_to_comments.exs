defmodule Njausteve.Repo.Migrations.AddAuthorsIdToComments do
  use Ecto.Migration

  def change do
    alter table("comments") do
      add :author_id, references(:authors, on_delete: :delete_all)
    end
  end
end
