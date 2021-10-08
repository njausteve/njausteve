defmodule NjausteveWeb.PostView do
  use NjausteveWeb, :view

  def truncate(text, opts \\ []) do
    max_length = opts[:max_length] || 50
    omission = opts[:omission] || "..."

    cond do
      not String.valid?(text) ->
        text

      String.length(text) < max_length ->
        text

      true ->
        length_with_omission = max_length - String.length(omission)

        "#{String.slice(text, 0, length_with_omission)}#{omission}"
    end
  end

  def path_list(path) do
    case path_list = Path.split(path) do
      ["/" | tail] -> tail
      _ -> path_list
    end
  end
end
