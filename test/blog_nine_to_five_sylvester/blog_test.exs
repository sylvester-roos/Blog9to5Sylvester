defmodule BlogNineToFiveSylvester.BlogTest do
  use BlogNineToFiveSylvester.DataCase

  alias BlogNineToFiveSylvester.Blog

  describe "posts" do
    alias BlogNineToFiveSylvester.Blog.Post

    import BlogNineToFiveSylvester.BlogFixtures

    @invalid_attrs %{post_id: nil, author: nil, text: nil, title: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{author: "some author", text: "some text", title: "some title"}

      assert {:ok, %Post{} = post} = Blog.create_post(valid_attrs)
      assert post.author == "some author"
      assert post.text == "some text"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()

      update_attrs = %{
        author: "some updated author",
        text: "some updated text",
        title: "some updated title"
      }

      assert {:ok, %Post{} = post} = Blog.update_post(post, update_attrs)
      assert post.author == "some updated author"
      assert post.text == "some updated text"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end

  describe "comments" do
    alias BlogNineToFiveSylvester.Blog.Comment

    import BlogNineToFiveSylvester.BlogFixtures

    @invalid_attrs %{author: nil, text: nil}

    test "list_comments/0 returns all comments" do
      post = post_fixture()
      comment = comment_fixture(post.id)
      assert Blog.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      post = post_fixture()
      comment = comment_fixture(post.id)
      assert Blog.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{post_id: post_fixture().id, author: "some author", text: "some text"}

      assert {:ok, %Comment{} = comment} = Blog.create_comment(valid_attrs)
      assert comment.author == "some author"
      assert comment.text == "some text"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      post = post_fixture()
      comment = comment_fixture(post.id)
      update_attrs = %{author: "some updated author", text: "some updated text"}

      assert {:ok, %Comment{} = comment} = Blog.update_comment(comment, update_attrs)
      assert comment.author == "some updated author"
      assert comment.text == "some updated text"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      post = post_fixture()
      comment = comment_fixture(post.id)
      assert {:error, %Ecto.Changeset{}} = Blog.update_comment(comment, @invalid_attrs)
      assert comment == Blog.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      post = post_fixture()
      comment = comment_fixture(post.id)
      assert {:ok, %Comment{}} = Blog.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      post = post_fixture()
      comment = comment_fixture(post.id)
      assert %Ecto.Changeset{} = Blog.change_comment(comment)
    end
  end
end
