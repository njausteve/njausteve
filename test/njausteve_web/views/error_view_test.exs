defmodule NjausteveWeb.ErrorViewTest do
  use NjausteveWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  setup %{conn: conn} do
    conn =
      conn
      |> Plug.Conn.put_private(:phoenix_endpoint, @endpoint)
      |> Pow.Plug.put_config(otp_app: :njausteve)

    {:ok, conn: conn}
  end

  test "renders 404.html", %{conn: conn} do
    assert render_to_string(NjausteveWeb.ErrorView, "404.html", conn: conn) =~
             "The page you are trying to access does not exist."
  end

  test "renders 500.html" do
    assert render_to_string(NjausteveWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end
end
