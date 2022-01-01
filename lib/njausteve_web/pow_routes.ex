defmodule NjausteveWeb.Pow.Routes do
  use Pow.Phoenix.Routes
  alias NjausteveWeb.Router.Helpers, as: Routes

  def after_sign_in_path(conn), do: Routes.post_path(conn, :index)
  def user_already_authenticated_path(conn), do: Routes.post_path(conn, :index)
  def after_sign_out_path(conn), do: Routes.page_path(conn, :index)
end
