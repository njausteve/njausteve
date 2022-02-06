defmodule NjausteveWeb.MarkdownHelpers do
  @moduledoc """
   Conviniences for rendering and parsing markdown
  """
  use Phoenix.HTML

  @default_image "https://picsum.photos/1600/900"

  @doc """
  Converts markdown to html.
  """
  def markdown(body) do
    body
    |> Earmark.as_html!(pure_links: false)
    |> raw
  end

  def get_image_src(html_body) do
    html_body
    |> Earmark.as_html!()
    |> Floki.parse_document()
    |> case do
      {:ok, document} ->
        document
        |> Floki.find("img")
        |> Enum.flat_map(&Floki.attribute(&1, "src"))
        |> Enum.at(0)
        |> case do
          src when is_binary(src) -> src
          _ -> @default_image
        end

      _ ->
        @default_image
    end
  end
end
