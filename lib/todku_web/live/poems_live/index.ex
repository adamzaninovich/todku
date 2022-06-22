defmodule TodkuWeb.PoemsLive.Index do
  use TodkuWeb, :live_view

  alias Todku.Entries
  alias Todku.Entries.Poem
  alias TodkuWeb.PoemLive.PoemComponent

  def render_search(assigns) do
    ~H"""
    <.form let={f} for={:search} id="search-form" phx-change="search">
      <div class="form-control">
        <div class="relative">
          <%= text_input(f, :term, placeholder: "Poem Search", class: "w-full pr-16 bg-neutral-focus text-neutral-content input input-primary input-bordered") %>
          <%= submit class: "absolute top-0 right-0 rounded-l-none btn btn-primary" do %>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-6 h-6 text-base-content stroke-current">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
            </svg>
          <% end %>
        </div>
      </div>
    </.form>
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
    |> assign(:page_title, "Edit Poem")
    |> assign(:poem, Entries.get_poem!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Poem")
    |> assign(:poem, %Poem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Poem")
    |> assign(:poem, nil)
  end

  @impl true
  def handle_event("search", %{"search" => %{"term" => ""}}, socket) do
    {:noreply, assign(socket, :poems_collection, list_poems())}
  end

  def handle_event("search", %{"search" => %{"term" => term}}, socket) do
    poems = Entries.search_poems(term)
    {:noreply, assign(socket, :poems_collection, poems)}
  end

  defp list_poems do
    Entries.list_poems()
  end
end
