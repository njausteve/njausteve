defmodule Njausteve.Repo.Migrations.CreatePostsCategories do
  use Ecto.Migration

  def change do
    create table(:posts_categories) do
      add :post_id, :integer
      add :category_id, :integer

      timestamps()
    end

    create unique_index(:posts_categories, [:post_id, :category_id])
  end
end
