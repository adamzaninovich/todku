defmodule TodkuWeb.PoemsLive.Index do
  use TodkuWeb, :live_view

  alias Todku.Entries
  alias Todku.Entries.Poems

  # TODO
  # - make search work
  # - make about page
  # - figure out export/import
  # - password protect add page

  def render_search(assigns) do
    ~H"""
    <div class="form-control">
      <div class="relative">
        <input type="text" placeholder="Poem Search" class="w-full pr-16 bg-neutral-focus text-neutral-content input input-primary input-bordered"/>
        <button class="absolute top-0 right-0 rounded-l-none btn btn-primary">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-6 h-6 text-base-content stroke-current">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
        </button>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :poems_collection, list_poems())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Poems")
    |> assign(:poems, Entries.get_poems!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Poems")
    |> assign(:poems, %Poems{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Poems")
    |> assign(:poems, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    poems = Entries.get_poems!(id)
    {:ok, _} = Entries.delete_poems(poems)

    {:noreply, assign(socket, :poems_collection, list_poems())}
  end

  defp list_poems do
    Entries.list_poems()
  end
end
