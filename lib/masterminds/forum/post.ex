defmodule Masterminds.Forum.Post do
  @moduledoc """
    The Post Model
  """
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :slug}

  schema "posts" do
    field :body, :string
    field :image, :string
    field :slug, :string, unique: true
    field :tags, {:array, :string}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :tags, :image])
    |> validate_required([:title, :body])
    |> unique_constraint(:slug)
    |> validate_length(:title, min: 3)
    |> validate_length(:body, max: 180)
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
end
