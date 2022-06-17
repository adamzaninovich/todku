defmodule TodkuWeb.Plugs.Redirect do
  import Plug.Conn
  # import Phoenix.Controller, only: [redirect: 2]

  def init(to: path), do: path

  def call(conn, path) do
    Phoenix.Controller.redirect(conn, to: path)
  end
end
