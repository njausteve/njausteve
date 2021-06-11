defmodule Njausteve.Posts.PostCategories do
  @moduledoc """
  Post_categories module (joint).
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts_categories" do
    field :category_id, :integer
    field :post_id, :integer

    timestamps()
  end

  @doc false
  def changeset(post_categories, attrs) do
    post_categories
    |> cast(attrs, [:post_id, :category_id])
    |> validate_required([:post_id, :category_id])
    |> unique_constraint(:post_id)
    |> unique_constraint(:category_id)
  end
end
