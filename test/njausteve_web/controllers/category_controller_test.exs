defmodule NjausteveWeb.CategoryControllerTest do
  @moduledoc false
  use NjausteveWeb.ConnCase

  alias Njausteve.Categories
  alias Njausteve.Users.User

  setup %{conn: conn} do
    user = %User{email: "test@example.com", role: "admin"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :njausteve)

    {:ok, conn: conn}
  end

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:category) do
    {:ok, category} = Categories.create_category(@create_attrs)
    category
  end

  describe "index" do
    test "lists all categories", %{conn: authed_conn} do
      conn = get(authed_conn, Routes.category_path(authed_conn, :index))
      assert html_response(conn, 200) =~ "Listing Categories"
    end
  end

  describe "new category" do
    test "renders form", %{conn: authed_conn} do
      conn = get(authed_conn, Routes.category_path(authed_conn, :new))
      assert html_response(conn, 200) =~ "New Category"
    end
  end

  describe "create category" do
    test "redirects to show when data is valid", %{conn: authed_conn} do
      conn =
        post(authed_conn, Routes.category_path(authed_conn, :create), category: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.category_path(conn, :show, id)

      conn = get(authed_conn, Routes.category_path(authed_conn, :show, id))
      assert html_response(conn, 200) =~ "Show Category"
    end

    test "renders errors when data is invalid", %{conn: authed_conn} do
      conn =
        post(authed_conn, Routes.category_path(authed_conn, :create), category: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Category"
    end
  end

  describe "edit category" do
    setup [:create_category]

    test "renders form for editing chosen category", %{conn: authed_conn, category: category} do
      conn = get(authed_conn, Routes.category_path(authed_conn, :edit, category))
      assert html_response(conn, 200) =~ "Edit Category"
    end
  end

  describe "update category" do
    setup [:create_category]

    test "redirects when data is valid", %{conn: authed_conn, category: category} do
      conn =
        put(authed_conn, Routes.category_path(authed_conn, :update, category),
          category: @update_attrs
        )

      assert redirected_to(conn) == Routes.category_path(conn, :show, category)

      conn = get(authed_conn, Routes.category_path(authed_conn, :show, category))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: authed_conn, category: category} do
      conn =
        put(authed_conn, Routes.category_path(authed_conn, :update, category),
          category: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Category"
    end
  end

  describe "delete category" do
    setup [:create_category]

    test "deletes chosen category", %{conn: authed_conn, category: category} do
      conn = delete(authed_conn, Routes.category_path(authed_conn, :delete, category))
      assert redirected_to(conn) == Routes.category_path(conn, :index)

      assert_error_sent 404, fn ->
        get(authed_conn, Routes.category_path(authed_conn, :show, category))
      end
    end
  end

  defp create_category(_) do
    category = fixture(:category)
    %{category: category}
  end
end
