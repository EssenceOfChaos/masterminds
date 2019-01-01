defmodule Masterminds.Forum.Post do
  @moduledoc """
    The Post Model
  """
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  @derive {Phoenix.Param, key: :slug}

  schema "posts" do
    field :body, :string
    field :image, :string
    field :slug, :string, unique: true
    field :tags, {:array, :string}
    field :title, :string
    field :author, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :tags, :image, :author])
    |> validate_required([:title, :body])
    |> unique_constraint(:slug)
    |> validate_length(:title, min: 3)
    |> validate_length(:body, max: 300)
    |> process_slug
  end

  ## PRIVATE ##
  defp process_slug(%Ecto.Changeset{valid?: validity, changes: %{title: title}} = changeset) do
    case validity do
      true -> put_change(changeset, :slug, Slugger.slugify_downcase(title))
      false -> changeset
    end
  end

  defp process_slug(changeset), do: changeset

  def search(query, search_term) do
    wildcard_search = "%#{search_term}%"

    from(post in query,
      where: ilike(post.title, ^wildcard_search),
      or_where: ilike(post.body, ^wildcard_search)
    )
  end

end
