defmodule NjausteveWeb.PageController do
  use NjausteveWeb, :controller

  alias Njausteve.Posts

  def index(conn, _params) do
    conn =
      case featured_posts() do
        [] ->
          conn
          |> assign(:featured_posts, [])
          |> assign(:top_featured_post, [])

        [top_featured_post | featured_posts] ->
          conn
          |> assign(:featured_posts, featured_posts)
          |> assign(:top_featured_post, top_featured_post)
      end

    render(conn, "index.html")
  end

  defp featured_posts do
    Posts.list_posts(preload: [:author, :tags])
  end
end
