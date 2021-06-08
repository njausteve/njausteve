defmodule NjausteveWeb.PostController do
  use NjausteveWeb, :controller

  alias Njausteve.Posts
  alias Njausteve.Posts.Post

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Posts.change_post(%Post{})
    publishing_status_options = Posts.publish_status_to_dropdown()

    render(conn, "new.html",
      changeset: changeset,
      publishing_status_options: publishing_status_options
    )
  end

  def create(conn, %{"post" => post_params}) do
    publishing_status_options = Posts.publish_status_to_dropdown()

    case Posts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          publishing_status_options: publishing_status_options
        )
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    publishing_status_options = Posts.publish_status_to_dropdown()

    changeset = Posts.change_post(post)

    render(conn, "edit.html",
      post: post,
      changeset: changeset,
      publishing_status_options: publishing_status_options
    )
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)
    publishing_status_options = Posts.publish_status_to_dropdown()

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          post: post,
          changeset: changeset,
          publishing_status_options: publishing_status_options
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
