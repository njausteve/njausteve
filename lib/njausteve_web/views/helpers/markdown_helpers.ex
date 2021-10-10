defmodule NjausteveWeb.MarkdownHelpers do
  @moduledoc """
   Conviniences for rendering and parsing markdown
  """
  use Phoenix.HTML

  @doc """
  Converts markdown to html.
  """
  def markdown(body) do
    body
    |> Earmark.as_html!()
    |> raw
  end
end
