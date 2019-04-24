defmodule MastermindsWeb.AuthController do
  use MastermindsWeb, :controller

  plug(Ueberauth)

  alias Masterminds.Auth.UserFromAuth

  @spec logout(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def logout(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> assign(:user_signed_in?, false)
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @spec callback(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case UserFromAuth.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> assign(:current_user, user)
        |> assign(:user_signed_in?, true)
        |> put_flash(:info, "Successfully authenticated as " <> user.name <> ".")
        |> put_session(:user_id, user.id)
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
