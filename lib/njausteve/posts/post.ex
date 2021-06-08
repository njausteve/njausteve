defmodule Njausteve.Posts.Post do
  @moduledoc """
  Post module.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Njausteve.Authors.Author
  alias Njausteve.Comments.Comment

  @publishing_status [
    {"Unpublished", "unpublished"},
    {"Pre-Production", "pre-production"},
    {"Post-Production", "post-production"},
    {"Published", "published"}
  ]

  @doc """
  Production status of a Post.
  """
  def publishing_status, do: @publishing_status

  schema "posts" do
    field :body, :string
    field :meta_title, :string
    field :publishing_status, :string
    field :slug, :string
    field :summary, :string
    field :title, :string
    field :views, :integer

    has_many :comments, Comment
    belongs_to :author, Author

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :slug, :meta_title, :body, :summary, :publishing_status, :views])
    |> validate_required([:title, :slug, :meta_title, :body, :summary, :publishing_status, :views])
    |> validate_inclusion(:publishing_status, [
      "unpublished",
      "pre-production",
      "post-production",
      "published"
    ])
  end
end
