defmodule Masterminds.Forum do
  @moduledoc """
  The Forum context.
  """

  import Ecto.Query, warn: false
  alias Masterminds.Repo

  alias Masterminds.Forum.Post


  def list_posts(params) do
    search_term = get_in(params, ["query"])
    Post
    |> Post.search(search_term)
    |> Repo.all()
  end


  def get(slug) do
    Repo.get_by(Post, slug: slug)
  end

  def get(slug, true) do
    Repo.get_by(Post, slug: slug)
  end


  def get_post!(id), do: Repo.get!(Post, id)


  def create_post(user, attrs \\ %{}) do
    author = "#{user.name}/#{user.id}"

    %Post{author: author}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end


  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end


  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end


  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
