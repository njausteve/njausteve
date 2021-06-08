defmodule Njausteve.Authors.Author do
  @moduledoc """
  Author module.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Njausteve.Posts.Post
  alias Njausteve.Comments.Comment

  schema "authors" do
    field :bio, :string
    field :first_name, :string
    field :last_name, :string

    has_many :posts, Post
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:first_name, :last_name, :bio])
    |> validate_required([:first_name, :last_name, :bio])
  end
end
