defmodule NjausteveWeb.BlogControllerTest do
  use NjausteveWeb.ConnCase

  alias Njausteve.Posts

  @create_attrs [
    %{
      body: "some body",
      meta_title: "some meta_title",
      publishing_status: "published",
      slug: "some-slug",
      summary: "some summary",
      title: "some title",
      views: 42,
      Tags: ["Hot article", "writing"]
    },
    %{
      body: "some other body",
      meta_title: "some other meta_title",
      publishing_status: "published",
      slug: "some-other-slug",
      summary: "some other summary",
      title: "some other title",
      views: 42,
      Tags: ["Engineering", "writing"]
    }
  ]

  def fixture(:post, attributes) do
    {:ok, post} = Posts.create_post(attributes)
    post
  end

  describe "index" do
    setup [:create_posts]

    test "lists all blogs", %{conn: conn, posts: posts} do
      conn = get(conn, Routes.blog_path(conn, :index))

      for post <- posts do
        assert html_response(conn, 200) =~ post.title
      end
    end
  end

  describe "show" do
    setup [:create_posts]

    test "shows blog when given slug is valid", %{conn: conn, posts: posts} do
      for post <- posts do
        conn = get(conn, Routes.blog_path(conn, :show, post.slug))
        assert html_response(conn, 200) =~ post.title
      end
    end
  end

  defp create_posts(_) do
    posts = Enum.map(@create_attrs, &fixture(:post, &1))

    %{posts: posts}
  end
end
