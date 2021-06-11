defmodule Njausteve.Repo.Migrations.AddPostToComments do
  use Ecto.Migration

  def change do
    drop constraint(:comments, "comments_post_id_fkey")

    alter table("comments") do
      modify :post_id, references(:posts, on_delete: :delete_all)
    end

    create index(:comments, [:author_id])
  end
end
