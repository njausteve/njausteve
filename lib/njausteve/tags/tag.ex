defmodule Njausteve.Tags.Tag do
  @moduledoc """
  Tag module
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Njausteve.Posts.Post

  schema "tags" do
    field :name, :string

    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
