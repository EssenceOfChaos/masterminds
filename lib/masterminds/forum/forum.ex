defmodule Masterminds.Forum do
  @moduledoc """
  The Forum context.
  """

  import Ecto.Query, warn: false
  alias Masterminds.Repo

  alias Masterminds.Forum.Post


  def list_posts do
    Repo.all(Post)
  end


  def get(slug) do
    Repo.get_by(Post, slug: slug)
  end

  def get(slug, true) do
    Repo.get_by(Post, slug: slug)
  end


  def get_post!(id), do: Repo.get!(Post, id)


  def create_post(attrs \\ %{}) do
    %Post{}
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
