defmodule Masterminds.Assessments.Quiz do
  use Ecto.Schema
  import Ecto.Changeset


  schema "quizzes" do
    field :points, :integer
    field :points_possible, :integer
    field :topic, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:topic, :user, :points, :points_possible])
    |> validate_required([:topic, :user, :points, :points_possible])
  end
end
