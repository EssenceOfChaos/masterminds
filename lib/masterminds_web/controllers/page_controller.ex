defmodule MastermindsWeb.PageController do
  use MastermindsWeb, :controller

  def index(conn, _params) do
    conn
    |> IO.inspect
    |> render("index.html", current_user: get_session(conn, :current_user))
  end
end
