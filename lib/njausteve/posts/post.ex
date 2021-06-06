defmodule Njausteve.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :meta_title, :string
    field :publishing_status, :string
    field :slug, :string
    field :summary, :string
    field :title, :string
    field :views, :integer

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :slug, :meta_title, :body, :summary, :publishing_status, :views])
    |> validate_required([:title, :slug, :meta_title, :body, :summary, :publishing_status, :views])
  end
end
