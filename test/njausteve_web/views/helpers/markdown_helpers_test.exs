defmodule NjausteveWeb.MarkdownHelpersTest do
  use NjausteveWeb.ConnCase, async: true

  import NjausteveWeb.MarkdownHelpers

  test "renders html raw html from makdown" do
    {:safe, result} = markdown("**bold me**")

    assert result == "<p><strong>bold me</strong></p>\n"
  end

  test "leaves text with no markdown alone" do
    {:safe, result} = markdown("bold me")

    assert result == "<p>bold me</p>\n"
  end
end
