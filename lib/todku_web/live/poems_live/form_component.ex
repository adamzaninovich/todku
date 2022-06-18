defmodule TodkuWeb.PoemsLive.FormComponent do
  use TodkuWeb, :live_component

  alias Todku.Entries

  @impl true
  def update(%{poem: poem} = assigns, socket) do
    changeset = Entries.change_poem(poem)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"poem" => poem_params}, socket) do
    changeset =
      socket.assigns.poem
      |> Entries.change_poem(poem_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"poem" => poem_params}, socket) do
    save_poem(socket, socket.assigns.action, poem_params)
  end

  defp save_poem(socket, :edit, poem_params) do
    case Entries.update_poem(socket.assigns.poem, poem_params) do
      {:ok, _poem} ->
        {:noreply,
         socket
         |> put_flash(:info, "Poem updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_poem(socket, :new, poem_params) do
    case Entries.create_poem(poem_params) do
      {:ok, _poem} ->
        {:noreply,
         socket
         |> put_flash(:info, "Poem created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
