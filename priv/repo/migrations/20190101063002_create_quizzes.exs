defmodule Masterminds.Repo.Migrations.CreateQuizzes do
  use Ecto.Migration

  def change do
    create table(:quizzes) do
      add :topic, :string
      add :user, :string
      add :points, :integer
      add :points_possible, :integer

      timestamps()
    end

  end
end
