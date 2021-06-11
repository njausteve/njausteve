defmodule Njausteve.Posts.PostTags do
  @moduledoc """
  Post_tags module (joint).
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts_categories" do
    field :post_id, :integer
    field :tag_id, :integer

    timestamps()
  end

  @doc false
  def changeset(post_tags, attrs) do
    post_tags
    |> cast(attrs, [:post_id, :tag_id])
    |> validate_required([:post_id, :tag_id])
    |> unique_constraint(:post_id)
    |> unique_constraint(:tag_id)
  end
end
