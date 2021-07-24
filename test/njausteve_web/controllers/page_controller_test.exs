defmodule NjausteveWeb.PageControllerTest do
  use NjausteveWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Njausteve"
  end
end
