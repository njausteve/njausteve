defmodule Njausteve.Categories.Category do
  @moduledoc """
  Category module.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Njausteve.Posts.Post

  schema "categories" do
    field :name, :string

    many_to_many :posts, Post, join_through: "posts_categories"
    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
