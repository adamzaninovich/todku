defmodule TodkuWeb.PoemsLive.Show do
  use TodkuWeb, :live_view

  alias Todku.Entries

  @password "password"

  def authed?(password) do
    password == @password
  end

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:password, "")
      |> assign(:admin, false)

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _session, socket) do
    poem = Entries.get_poem!(id)
    text = String.replace(poem.text, "<br>", "\n")

    changeset = Entries.change_poem(poem, %{text: text})

    socket =
      socket
      |> assign(:text, text)
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:poem, poem)
      |> assign(:changeset, changeset)

    {:noreply, socket}
  end

  @impl true
  def handle_event("set-password", %{"auth" => %{"password" => password}}, socket) do
    {:noreply, assign(socket, :password, password)}
  end

  def handle_event("activate-admin", _params, socket) do
    {:noreply, assign(socket, :admin, true)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    if authed?(socket.assigns.password) do
      poem = Entries.get_poem!(id)
      {:ok, _} = Entries.delete_poem(poem)

      {:noreply, push_redirect(socket, to: Routes.poems_index_path(socket, :index))}
    else
      {:noreply, socket}
    end
  end

  def handle_event("save", params, socket) do
    if authed?(socket.assigns.password) do
      poem_params = params

      case Entries.update_poem(socket.poem, poem_params) do
        {:ok, _poem} ->
          {:noreply,
           socket
           |> put_flash(:info, "Poem created successfully")
           |> push_redirect(to: Routes.poems_new_path(socket, :new))}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, put_flash(socket, :error, "Errors: #{inspect(changeset.errors)}")}
      end
    else
      socket =
        socket
        |> put_flash(:error, "Not authenticated!")
        |> push_redirect(to: Routes.poems_index_path(socket, :index))

      {:noreply, socket}
    end
  end

  defp page_title(:show), do: "Show Poem"
  defp page_title(:edit), do: "Edit Poem"

  def render_locked_button_text(assigns, text) do
    if not authed?(assigns.password) do
      ~H"""
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" />
      </svg>
      <%= text %>
      """
    end
  end
end
