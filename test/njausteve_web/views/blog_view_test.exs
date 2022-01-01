defmodule NjausteveWeb.BlogViewTest do
  use NjausteveWeb.ConnCase, async: true

  alias NjausteveWeb.BlogView
  alias Njausteve.Posts.Post

  describe "time_to_read/1" do
    test "returns 0 if a posts body is empty" do
      post = %Post{}
      assert BlogView.time_to_read(post) == 0
    end

    test "returns time to read an posts body" do
      post_body = "Lorem Ipsum is the single greatest threat. We are not -
         we are not keeping up with other websites. Lorem Ipsum best
         not make any more threats to your website. It will be met with fire
         and fury like the world has never seen. Does everybody know that
         pig named Lorem Ipsum? An ‘extremely credible source’ has called
         my office and told me that Barack Obama’s placeholder text is a fraud.
         Porem Ipsum is the single greatest threat. We are not -
         we are not keeping up with other websites. Lorem Ipsum best
         not make any more threats to your website. It will be met with fire
         and fury like the world has never seen. Does everybody know that
         pig named Lorem Ipsum? An ‘extremely credible source’ has called
         my office and told me that Barack Obama’s placeholder text is a fraud. orem Ipsum is the single greatest threat. We are not -
         we are not keeping up with other websites. Lorem Ipsum best
         not make any more threats to your website. It will be met with fire
         and fury like the world has never seen. Does everybody know that
         pig named Lorem Ipsum? An ‘extremely credible source’ has called
         my office and told me that Barack Obama’s placeholder text is a fraud. orem Ipsum is the single greatest threat. We are not -
         we are not keeping up with other websites. Lorem Ipsum best
         not make any more threats to your website. It will be met with fire
         and fury like the world has never seen. Does everybody know that
         pig named Lorem Ipsum? An ‘extremely credible source’ has called
         my office and told me that Barack Obama’s placeholder text is a fraud."

      post = %Post{body: post_body}

      assert BlogView.time_to_read(post) == 1
    end
  end
end
