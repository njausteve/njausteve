defmodule NjausteveWeb.LayoutView do
  use NjausteveWeb, :view

  def admin_active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])

    if path == current_path do
      "bg-the-blue hover:bg-the-blue"
    else
      nil
    end
  end
end
