defmodule TodkuWeb.Router do
  use TodkuWeb, :router

  alias Plugs.Redirect

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TodkuWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", TodkuWeb do
    pipe_through :browser

    get "/", Redirect, to: "/poems"

    live "/about", AboutLive, :index

    live "/poems", PoemsLive.Index, :index
    live "/poems/new", PoemsLive.New, :new
    live "/poems/:id", PoemsLive.Show, :show
    live "/poems/:id/show/edit", PoemsLive.Show, :edit

    get "/download", DownloadController, :index
  end
end
