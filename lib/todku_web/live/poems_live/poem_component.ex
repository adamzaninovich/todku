defmodule TodkuWeb.PoemLive.PoemComponent do
  use TodkuWeb, :live_component

  @impl true
  def update(%{poem: poem, action: action}, socket) do
    {:ok, assign(socket, %{poem: poem, live_action: action})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={"poem-#{@poem.id}"} class="card w-full bg-base-100 shadow-xl hover:scale-105 transition-transform">
      <div class="card-body items-center text-center pb-0 px-0">
        <h2 class="card-title text-primary"><%= Calendar.strftime(@poem.date, "%a, %b %d %Y") %></h2>
        <p><%= raw @poem.text %></p>
        <%= render_actions(@live_action, assigns) %>
      </div>
    </div>
    """
  end

  defp render_actions(:index, assigns) do
    ~H"""
    <div class="card-actions w-full justify-end opacity-30 hover:opacity-100 duration-300">
      <%= live_patch to: Routes.poems_show_path(@socket, :show, @poem), class: "btn btn-sm btn-link text-secondary" do %>
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M6.672 1.911a1 1 0 10-1.932.518l.259.966a1 1 0 001.932-.518l-.26-.966zM2.429 4.74a1 1 0 10-.517 1.932l.966.259a1 1 0 00.517-1.932l-.966-.26zm8.814-.569a1 1 0 00-1.415-1.414l-.707.707a1 1 0 101.415 1.415l.707-.708zm-7.071 7.072l.707-.707A1 1 0 003.465 9.12l-.708.707a1 1 0 001.415 1.415zm3.2-5.171a1 1 0 00-1.3 1.3l4 10a1 1 0 001.823.075l1.38-2.759 3.018 3.02a1 1 0 001.414-1.415l-3.019-3.02 2.76-1.379a1 1 0 00-.076-1.822l-10-4z" clip-rule="evenodd" />
        </svg>
      <% end %>
    </div>
    """
  end

  defp render_actions(_other, assigns) do
    ~H"""
    <div class="card-actions w-full">&nbsp;</div>
    """
  end
end
