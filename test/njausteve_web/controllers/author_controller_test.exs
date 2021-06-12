defmodule NjausteveWeb.AuthorControllerTest do
  @moduledoc false
  use NjausteveWeb.ConnCase

  alias Njausteve.Authors
  alias Njausteve.Users.User

  setup %{conn: conn} do
    user = %User{email: "test@example.com", role: "admin"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :my_app)

    {:ok, conn: conn}
  end

  @create_attrs %{bio: "some bio", first_name: "some first_name", last_name: "some last_name"}
  @update_attrs %{
    bio: "some updated bio",
    first_name: "some updated first_name",
    last_name: "some updated last_name"
  }
  @invalid_attrs %{bio: nil, first_name: nil, last_name: nil}

  def fixture(:author) do
    {:ok, author} = Authors.create_author(@create_attrs)
    author
  end

  describe "index" do
    test "lists all authors", %{conn: authed_conn} do
      conn = get(authed_conn, Routes.author_path(authed_conn, :index))
      assert html_response(conn, 200) =~ "Listing Authors"
    end
  end

  describe "new author" do
    test "renders form", %{conn: authed_conn} do
      conn = get(authed_conn, Routes.author_path(authed_conn, :new))
      assert html_response(conn, 200) =~ "New Author"
    end
  end

  describe "create author" do
    test "redirects to show when data is valid", %{conn: authed_conn} do
      conn = post(authed_conn, Routes.author_path(authed_conn, :create), author: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.author_path(conn, :show, id)

      conn = get(authed_conn, Routes.author_path(authed_conn, :show, id))
      assert html_response(conn, 200) =~ "Show Author"
    end

    test "renders errors when data is invalid", %{conn: authed_conn} do
      conn = post(authed_conn, Routes.author_path(authed_conn, :create), author: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Author"
    end
  end

  describe "edit author" do
    setup [:create_author]

    test "renders form for editing chosen author", %{conn: authed_conn, author: author} do
      conn = get(authed_conn, Routes.author_path(authed_conn, :edit, author))
      assert html_response(conn, 200) =~ "Edit Author"
    end
  end

  describe "update author" do
    setup [:create_author]

    test "redirects when data is valid", %{conn: authed_conn, author: author} do
      conn =
        put(authed_conn, Routes.author_path(authed_conn, :update, author), author: @update_attrs)

      assert redirected_to(conn) == Routes.author_path(conn, :show, author)

      conn = get(authed_conn, Routes.author_path(authed_conn, :show, author))
      assert html_response(conn, 200) =~ "some updated bio"
    end

    test "renders errors when data is invalid", %{conn: authed_conn, author: author} do
      conn =
        put(authed_conn, Routes.author_path(authed_conn, :update, author), author: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Author"
    end
  end

  describe "delete author" do
    setup [:create_author]

    test "deletes chosen author", %{conn: authed_conn, author: author} do
      conn = delete(authed_conn, Routes.author_path(authed_conn, :delete, author))
      assert redirected_to(conn) == Routes.author_path(conn, :index)

      assert_error_sent 404, fn ->
        get(authed_conn, Routes.author_path(authed_conn, :show, author))
      end
    end
  end

  defp create_author(_) do
    author = fixture(:author)
    %{author: author}
  end
end
