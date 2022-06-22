defmodule TodkuWeb.Plugs.Redirect do
  @moduledoc "Allows easy redirection in the router"

  def init(to: path), do: path

  def call(conn, path) do
    Phoenix.Controller.redirect(conn, to: path)
  end
end
