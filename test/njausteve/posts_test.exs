defmodule Njausteve.PostsTest do
  use Njausteve.DataCase

  alias Njausteve.Posts

  describe "posts" do
    alias Njausteve.Posts.Post

    @valid_attrs %{
      body: "some body",
      meta_title: "some meta_title",
      publishing_status: "some publishing_status",
      slug: "some slug",
      summary: "some summary",
      title: "some title",
      views: 42
    }
    @update_attrs %{
      body: "some updated body",
      meta_title: "some updated meta_title",
      publishing_status: "some updated publishing_status",
      slug: "some updated slug",
      summary: "some updated summary",
      title: "some updated title",
      views: 43
    }
    @invalid_attrs %{
      body: nil,
      meta_title: nil,
      publishing_status: nil,
      slug: nil,
      summary: nil,
      title: nil,
      views: nil
    }

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Posts.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Posts.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.meta_title == "some meta_title"
      assert post.publishing_status == "some publishing_status"
      assert post.slug == "some slug"
      assert post.summary == "some summary"
      assert post.title == "some title"
      assert post.views == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Posts.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.meta_title == "some updated meta_title"
      assert post.publishing_status == "some updated publishing_status"
      assert post.slug == "some updated slug"
      assert post.summary == "some updated summary"
      assert post.title == "some updated title"
      assert post.views == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
