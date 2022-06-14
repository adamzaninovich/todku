defmodule TodkuWeb.PageController do
  use TodkuWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
