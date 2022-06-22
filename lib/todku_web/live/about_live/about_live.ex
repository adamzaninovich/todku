defmodule TodkuWeb.AboutLive do
  use TodkuWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:ok, socket}
  end
end
