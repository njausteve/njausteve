defmodule NjausteveWeb.PageController do
  use NjausteveWeb, :controller

  alias Njausteve.Posts

  def index(conn, _params) do
    [top_featured_post | featured_posts] = featured_posts()

    conn
    |> assign(:featured_posts, featured_posts)
    |> assign(:top_featured_post, top_featured_post)
    |> render("index.html")
  end

  defp featured_posts do
    Posts.list_posts(preload: [:author, :tags])
  end
end
