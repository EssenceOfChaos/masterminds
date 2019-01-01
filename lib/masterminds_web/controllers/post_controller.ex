defmodule MastermindsWeb.PostController do
  use MastermindsWeb, :controller

  alias Masterminds.Forum
  alias Masterminds.Forum.Post

  plug :secure

  def index(conn, params) do
    posts = Forum.list_posts(params)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Forum.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    user = get_session(conn, :current_user)
    case Forum.create_post(user, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "\"#{post.title}\" was created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   post = Forum.get_post!(id)
  #   render(conn, "show.html", post: post)
  # end
  def show(conn, %{"id" => slug}) do
    with %Post{} = post <- Forum.get(slug, true) do
      render(conn, "show.html", post: post)
    end
  end

  def edit(conn, %{"id" => id}) do
    current_user = get_session(conn, :current_user)
    post = Forum.get(id, true)

    if tl(String.split(post.author, "/")) == current_user.id do
      changeset = Forum.change_post(post)
      render(conn, "edit.html", post: post, changeset: changeset)
    else
      conn
      |> put_flash(:error, "Sorry, authors may only edit their own posts!")
      |> redirect(to: Routes.post_path(conn, :index))
    end

  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Forum.get_post!(id)

    case Forum.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    current_user = get_session(conn, :current_user)
    post = Forum.get(id, true)

## post.author takes the shape of name/unique_id
## to ensure post ownership we verify the id with current user id
## the following statement splits the string on "/"
## takes the tl aka the id and turns it back into a string and removes extra whitespace
    if String.trim(to_string(tl(String.split(post.author, "/")))) == current_user.id do
      {:ok, _post} = Forum.delete_post(post)
      conn
      |> put_flash(:info, "Post deleted successfully.")
      |> redirect(to: Routes.post_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Sorry, authors may only delete their own posts!")
      |> redirect(to: Routes.post_path(conn, :index))
    end
  end

  ## PRIVATE ##
  defp secure(conn, _params) do
      user = get_session(conn, :current_user)
      case user do
       nil ->
           conn |> redirect(to: "/auth/auth0") |> halt
       _ ->
         conn
         |> assign(:current_user, user)
      end
    end
end
