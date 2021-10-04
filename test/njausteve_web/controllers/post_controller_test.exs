defmodule NjausteveWeb.PostControllerTest do
  @moduledoc false

  use NjausteveWeb.ConnCase

  alias Njausteve.Posts
  alias Njausteve.Users.User

  setup %{conn: conn} do
    user = %User{email: "test@example.com", role: "admin"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :njausteve)

    {:ok, conn: conn}
  end

  @create_attrs %{
    body: "some body",
    meta_title: "some meta_title",
    publishing_status: "pre-production",
    slug: "some slug",
    summary: "some summary",
    title: "some title",
    views: 42
  }
  @update_attrs %{
    body: "some updated body",
    meta_title: "some updated meta_title",
    publishing_status: "pre-production",
    slug: "some updated slug",
    summary: "some updated summary",
    title: "some updated title",
    views: 43
  }
  @invalid_attrs %{
    body: nil,
    meta_title: nil,
    publishing_status: nil,
    slug: nil,
    summary: nil,
    title: nil,
    views: nil
  }

  def fixture(:post) do
    {:ok, post} = Posts.create_post(@create_attrs)
    post
  end

  describe "index" do
    test "lists all posts", %{conn: authed_conn} do
      conn = get(authed_conn, Routes.post_path(authed_conn, :index))
      assert html_response(conn, 200) =~ "Listing Posts"
    end
  end

  describe "new post" do
    test "renders form", %{conn: authed_conn} do
      conn = get(authed_conn, Routes.post_path(authed_conn, :new))
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    test "redirects to show when data is valid", %{conn: authed_conn} do
      conn = post(authed_conn, Routes.post_path(authed_conn, :create), post: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)

      conn = get(authed_conn, Routes.post_path(authed_conn, :show, id))
      assert html_response(conn, 200) =~ "Show Post"
    end

    test "renders errors when data is invalid", %{conn: authed_conn} do
      conn = post(authed_conn, Routes.post_path(authed_conn, :create), post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    setup [:create_post]

    test "renders form for editing chosen post", %{conn: authed_conn, post: post} do
      conn = get(authed_conn, Routes.post_path(authed_conn, :edit, post))
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post]

    test "redirects when data is valid", %{conn: authed_conn, post: post} do
      conn = put(authed_conn, Routes.post_path(authed_conn, :update, post), post: @update_attrs)
      assert redirected_to(conn) == Routes.post_path(conn, :show, post)

      conn = get(authed_conn, Routes.post_path(authed_conn, :show, post))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: authed_conn, post: post} do
      conn = put(authed_conn, Routes.post_path(authed_conn, :update, post), post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: authed_conn, post: post} do
      conn = delete(authed_conn, Routes.post_path(authed_conn, :delete, post))
      assert redirected_to(conn) == Routes.post_path(conn, :index)

      assert_error_sent 404, fn ->
        get(authed_conn, Routes.post_path(authed_conn, :show, post))
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    %{post: post}
  end
end
