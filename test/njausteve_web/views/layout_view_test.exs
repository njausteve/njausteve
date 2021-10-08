defmodule NjausteveWeb.LayoutViewTest do
  @moduledoc false
  use NjausteveWeb.ConnCase, async: true

  import NjausteveWeb.LayoutView

  setup %{conn: conn} do
    conn =
      conn
      |> Plug.Conn.put_private(:phoenix_endpoint, @endpoint)
      |> Pow.Plug.put_config(otp_app: :njausteve)

    {:ok, conn: conn}
  end

  test "returns active classes if path active", %{conn: conn} do
    path = Routes.post_path(conn, :index)

    classes =
      conn
      |> get(path)
      |> admin_active_class(path)

    assert classes == "bg-the-blue hover:bg-the-blue"
  end

  test "returns nil if path is not the active", %{conn: conn} do
    path = Routes.post_path(conn, :index)

    classes =
      conn
      |> get(path)
      |> admin_active_class("/admin")

    assert classes == nil
  end
end
