defmodule Njausteve.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :first_name, :string
      add :last_name, :string
      add :bio, :text
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create index(:authors, [:post_id])
  end
end
