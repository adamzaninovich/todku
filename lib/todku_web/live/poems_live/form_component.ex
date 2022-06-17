defmodule TodkuWeb.PoemsLive.FormComponent do
  use TodkuWeb, :live_component

  alias Todku.Entries

  @impl true
  def update(%{poems: poems} = assigns, socket) do
    changeset = Entries.change_poems(poems)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"poems" => poems_params}, socket) do
    changeset =
      socket.assigns.poems
      |> Entries.change_poems(poems_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"poems" => poems_params}, socket) do
    save_poems(socket, socket.assigns.action, poems_params)
  end

  defp save_poems(socket, :edit, poems_params) do
    case Entries.update_poems(socket.assigns.poems, poems_params) do
      {:ok, _poems} ->
        {:noreply,
         socket
         |> put_flash(:info, "Poems updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_poems(socket, :new, poems_params) do
    case Entries.create_poems(poems_params) do
      {:ok, _poems} ->
        {:noreply,
         socket
         |> put_flash(:info, "Poems created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
