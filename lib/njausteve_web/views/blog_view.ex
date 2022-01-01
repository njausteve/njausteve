defmodule NjausteveWeb.BlogView do
  use NjausteveWeb, :view

  alias Njausteve.Posts.Post

  def timeToRead(%Post{body: body}) when byte_size(body) > 0 do
    body
    |> String.split(~r{(\\n|[^\w'])+})
    |> Enum.filter(&(&1 != ""))
    |> Enum.count()
    |> div(200)
  end

  def timeToRead(_) do
    0
  end
end
