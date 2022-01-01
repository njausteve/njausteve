defmodule NjausteveWeb.BlogView do
  use NjausteveWeb, :view

  alias Njausteve.Posts.Post

  def time_to_read(%Post{} = %{body: body}) when byte_size(body) > 0 do
    body
    |> String.split(~r{(\\n|[^\w'])+})
    |> Enum.filter(&(&1 != ""))
    |> Enum.count()
    |> div(200)
  end

  def time_to_read(_post) do
    0
  end
end
