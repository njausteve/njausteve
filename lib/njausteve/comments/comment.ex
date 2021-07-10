defmodule Njausteve.Comments.Comment do
  @moduledoc """
  Comment module.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Njausteve.Authors.Author
  alias Njausteve.Comments.Comment
  alias Njausteve.Posts.Post

  schema "comments" do
    field :approved, :boolean, default: false
    field :body, :string
    field :parent_id, :id

    belongs_to :post, Post
    belongs_to :author, Author

    belongs_to :parent, Comment, foreign_key: :parent_id, references: :id, define_field: false
    has_many :children, Comment, foreign_key: :parent_id, references: :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :approved, :author])
    |> validate_required([:body, :approved, :author])
  end
end
