defmodule MastermindsWeb.LayoutView do
  use MastermindsWeb, :view
  import Plug.Conn
  @spec logged_in?(Plug.Conn.t()) :: boolean()
  def logged_in?(conn) do
    !!get_session(conn, :current_user)
  end
end
