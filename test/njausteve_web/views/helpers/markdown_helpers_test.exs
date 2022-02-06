defmodule NjausteveWeb.MarkdownHelpersTest do
  @moduledoc false

  use NjausteveWeb.ConnCase, async: true

  import NjausteveWeb.MarkdownHelpers

  describe "markdown/1" do
    test "renders html raw html from markdown" do
      {:safe, result} = markdown("**bold me**")

      assert result == "<p><strong>bold me</strong></p>\n"
    end

    test "leaves text with no markdown alone" do
      {:safe, result} = markdown("bold me")

      assert result == "<p>bold me</p>\n"
    end
  end

  describe "get_image_src/1" do
    test "return image src of the 1st image" do
      body_with_image =
        "![pipeline](https://miro.medium.com/max/1400/0*YmOZwT0AFJKjqQaY)\r\nLike many other programming languages,
          Elixir is subject to syntax additions, feature deprecation, and improvements over time.
          \r\n\r\nThis article introduces `tap/2`  and  `then/3`"

      assert get_image_src(body_with_image) ==
               "https://miro.medium.com/max/1400/0*YmOZwT0AFJKjqQaY"
    end

    test "return default image ig no image is found in the post body" do
      body_without_image = "Like many other programming languages,
          Elixir is subject to syntax additions, feature deprecation, and improvements over time.
          \r\n\r\nThis article introduces `tap/2`  and  `then/3`"

      assert get_image_src(body_without_image) == "https://picsum.photos/1600/900"
    end
  end
end
