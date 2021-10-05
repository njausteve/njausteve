defmodule NjausteveWeb.BlogController do
  use NjausteveWeb, :controller

  alias Njausteve.Posts

  def index(conn, _params) do
    conn =
      case all_posts = posts() do
        [] ->
          conn
          |> assign(:latest_post, [])
          |> assign(:posts, [])

        [latest_post | posts] ->
          conn
          |> assign(:posts, posts)
          |> assign(:latest_post, latest_post)
          |> assign(:tags, get(all_posts, :tags))
          |> assign(:recent_posts, all_posts)
          |> assign(:categories, get(all_posts, :categories))
      end

    render(conn, "index.html")
  end

  def show(conn, %{"slug" => slug}) do
    post = Posts.get_post!(slug: slug)
    render(conn, "show.html", post: post)
  end

  defp posts do
    Posts.list_posts(preload: [:categories, :author, :tags])
  end

  defp get(posts, attr) do
    posts
    |> Enum.reduce([], fn %{^attr => attr}, acc -> attr ++ acc end)
    |> Enum.uniq()
    |> Enum.take(10)
  end
end
