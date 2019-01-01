defmodule Masterminds.AssessmentsTest do
  use Masterminds.DataCase

  alias Masterminds.Assessments

  describe "quizzes" do
    alias Masterminds.Assessments.Quiz

    @valid_attrs %{points: 42, points_possible: 42, topic: "some topic", user: "some user"}
    @update_attrs %{points: 43, points_possible: 43, topic: "some updated topic", user: "some updated user"}
    @invalid_attrs %{points: nil, points_possible: nil, topic: nil, user: nil}

    def quiz_fixture(attrs \\ %{}) do
      {:ok, quiz} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Assessments.create_quiz()

      quiz
    end

    test "list_quizzes/0 returns all quizzes" do
      quiz = quiz_fixture()
      assert Assessments.list_quizzes() == [quiz]
    end

    test "get_quiz!/1 returns the quiz with given id" do
      quiz = quiz_fixture()
      assert Assessments.get_quiz!(quiz.id) == quiz
    end

    test "create_quiz/1 with valid data creates a quiz" do
      assert {:ok, %Quiz{} = quiz} = Assessments.create_quiz(@valid_attrs)
      assert quiz.points == 42
      assert quiz.points_possible == 42
      assert quiz.topic == "some topic"
      assert quiz.user == "some user"
    end

    test "create_quiz/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assessments.create_quiz(@invalid_attrs)
    end

    test "update_quiz/2 with valid data updates the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{} = quiz} = Assessments.update_quiz(quiz, @update_attrs)
      assert quiz.points == 43
      assert quiz.points_possible == 43
      assert quiz.topic == "some updated topic"
      assert quiz.user == "some updated user"
    end

    test "update_quiz/2 with invalid data returns error changeset" do
      quiz = quiz_fixture()
      assert {:error, %Ecto.Changeset{}} = Assessments.update_quiz(quiz, @invalid_attrs)
      assert quiz == Assessments.get_quiz!(quiz.id)
    end

    test "delete_quiz/1 deletes the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{}} = Assessments.delete_quiz(quiz)
      assert_raise Ecto.NoResultsError, fn -> Assessments.get_quiz!(quiz.id) end
    end

    test "change_quiz/1 returns a quiz changeset" do
      quiz = quiz_fixture()
      assert %Ecto.Changeset{} = Assessments.change_quiz(quiz)
    end
  end
end
