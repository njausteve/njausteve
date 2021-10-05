defmodule Njausteve.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Njausteve.Repo

  alias Njausteve.Posts.Post

  @doc """
  Returns the list of posts.

  ## Options
  * `:status` - Scope results by Post publishing status: `all` and others. (defaults: `all`).

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(opts \\ []) do
    status_opt = Keyword.get(opts, :status, "all")
    preload_opt = Keyword.get(opts, :preload, [])

    Post
    |> with_status(status_opt)
    |> preload(^preload_opt)
    |> Repo.all()
  end

  defp with_status(query, status) when status in ["all", "", nil], do: query
  defp with_status(query, status), do: from(q in query, where: q.status == ^status)

  @doc """
  Gets a single post using the id or slug

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(id: 123)
      %Post{}

      iex> get_post!(id: 456)
      ** (Ecto.NoResultsError)

      iex> get_post!(slug: "hello-world-post")
      %Post{}

      iex> get_post!(slug: "non-existent-slug")
      ** (Ecto.NoResultsError)
  """
  def get_post!(id: id) do
    Post
    |> Repo.get!(id)
  end

  def get_post!(slug: slug) do
    Post
    |> Repo.get_by!(slug: slug)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  @doc """
  Returns Post publishing status to a dropdown list

  ## Examples

      iex> publish_status_to_dropdown()
      %Ecto.publish_status_to_dropdown()

  """
  def publish_status_to_dropdown do
    Post.publishing_status()
  end
end
