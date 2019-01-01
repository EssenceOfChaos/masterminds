defmodule MastermindsWeb.QuizController do
  use MastermindsWeb, :controller

  alias Masterminds.Assessments
  alias Masterminds.Assessments.Quiz

  def index(conn, _params) do
    quizzes = Assessments.list_quizzes()
    render(conn, "index.html", quizzes: quizzes)
  end

  def new(conn, _params) do
    changeset = Assessments.change_quiz(%Quiz{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"quiz" => quiz_params}) do
    case Assessments.create_quiz(quiz_params) do
      {:ok, quiz} ->
        conn
        |> put_flash(:info, "Quiz created successfully.")
        |> redirect(to: Routes.quiz_path(conn, :show, quiz))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    quiz = Assessments.get_quiz!(id)
    render(conn, "show.html", quiz: quiz)
  end

  def edit(conn, %{"id" => id}) do
    quiz = Assessments.get_quiz!(id)
    changeset = Assessments.change_quiz(quiz)
    render(conn, "edit.html", quiz: quiz, changeset: changeset)
  end

  def update(conn, %{"id" => id, "quiz" => quiz_params}) do
    quiz = Assessments.get_quiz!(id)

    case Assessments.update_quiz(quiz, quiz_params) do
      {:ok, quiz} ->
        conn
        |> put_flash(:info, "Quiz updated successfully.")
        |> redirect(to: Routes.quiz_path(conn, :show, quiz))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quiz: quiz, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quiz = Assessments.get_quiz!(id)
    {:ok, _quiz} = Assessments.delete_quiz(quiz)

    conn
    |> put_flash(:info, "Quiz deleted successfully.")
    |> redirect(to: Routes.quiz_path(conn, :index))
  end

  def begin(conn, %{"topic" => topic}) do
    case topic do
      "elixir"     -> render(conn, "elixir.html")
      "golang"     -> render(conn, "golang.html")
      "javascript" -> render(conn, "javascript.html")

    end
  end
end
