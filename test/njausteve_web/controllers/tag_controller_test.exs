defmodule NjausteveWeb.TagControllerTest do
  use NjausteveWeb.ConnCase

  alias Njausteve.Tags
  alias Njausteve.Users.User

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:tag) do
    {:ok, tag} = Tags.create_tag(@create_attrs)
    tag
  end

  setup %{conn: conn} do
    user = %User{email: "test@example.com"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :my_app)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all tags", %{conn: authed_conn} do
      conn = get(authed_conn, Routes.tag_path(authed_conn, :index))
      assert html_response(conn, 200) =~ "Listing Tags"
    end
  end

  describe "new tag" do
    test "renders form", %{conn: authed_conn} do
      conn = get(authed_conn, Routes.tag_path(authed_conn, :new))
      assert html_response(conn, 200) =~ "New Tag"
    end
  end

  describe "create tag" do
    test "redirects to show when data is valid", %{conn: authed_conn} do
      conn = post(authed_conn, Routes.tag_path(authed_conn, :create), tag: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tag_path(conn, :show, id)


      conn = get(authed_conn, Routes.tag_path(authed_conn, :show, id))

      assert html_response(conn, 200) =~ "Show Tag"
    end

    test "renders errors when data is invalid", %{conn: authed_conn} do
      conn = post(authed_conn, Routes.tag_path(authed_conn, :create), tag: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tag"
    end
  end

  describe "edit tag" do
    setup [:create_tag]

    test "renders form for editing chosen tag", %{conn: authed_conn, tag: tag} do
      conn = get(authed_conn, Routes.tag_path(authed_conn, :edit, tag))
      assert html_response(conn, 200) =~ "Edit Tag"
    end
  end

  describe "update tag" do
    setup [:create_tag]

    test "redirects when data is valid", %{conn: authed_conn, tag: tag} do
      conn = put(authed_conn, Routes.tag_path(authed_conn, :update, tag), tag: @update_attrs)
      assert redirected_to(conn) == Routes.tag_path(conn, :show, tag)

      conn = get(authed_conn, Routes.tag_path(authed_conn, :show, tag))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: authed_conn, tag: tag} do
      conn = put(authed_conn, Routes.tag_path(authed_conn, :update, tag), tag: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tag"
    end
  end

  describe "delete tag" do
    setup [:create_tag]

    test "deletes chosen tag", %{conn: authed_conn, tag: tag} do
      conn = delete(authed_conn, Routes.tag_path(authed_conn, :delete, tag))
      assert redirected_to(conn) == Routes.tag_path(conn, :index)

      assert_error_sent 404, fn ->
        get(authed_conn, Routes.tag_path(authed_conn, :show, tag))
      end
    end
  end

  defp create_tag(_) do
    tag = fixture(:tag)
    %{tag: tag}
  end
end
