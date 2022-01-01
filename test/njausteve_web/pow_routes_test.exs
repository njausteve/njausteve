defmodule NjausteveWeb.Pow.RoutesTest do
  @moduledoc false
  use NjausteveWeb.ConnCase

  import NjausteveWeb.Pow.Routes

  setup %{conn: conn} do
    conn =
      conn
      |> Plug.Conn.put_private(:phoenix_endpoint, @endpoint)
      |> Pow.Plug.put_config(otp_app: :njausteve)

    {:ok, conn: conn}
  end

  test "after_sign_in_path/1 returns admin posts root path", %{conn: conn} do
    admin_posts_path = Routes.post_path(conn, :index)

    assert after_sign_in_path(conn) == admin_posts_path
  end

  test "user_already_authenticated_path/1 returns admin posts root path", %{conn: conn} do
    admin_posts_path = Routes.post_path(conn, :index)

    assert user_already_authenticated_path(conn) == admin_posts_path
  end

  test "after_sign_out_path/1 returns home page path", %{conn: conn} do
    home_page_path = Routes.page_path(conn, :index)

    assert after_sign_out_path(conn) == home_page_path
  end
end
