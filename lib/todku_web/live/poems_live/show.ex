defmodule TodkuWeb.PoemsLive.Show do
  use TodkuWeb, :live_view

  alias Todku.Entries

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:poems, Entries.get_poems!(id))}
  end

  defp page_title(:show), do: "Show Poems"
  defp page_title(:edit), do: "Edit Poems"
end
