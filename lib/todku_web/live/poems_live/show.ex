defmodule TodkuWeb.PoemsLive.Show do
  use TodkuWeb, :live_view

  alias Todku.Entries

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    poem = Entries.get_poem!(id)
    text = String.replace(poem.text, "<br>", "\n")

    changeset = Entries.change_poem(poem, %{text: text})

    changeset =
      {:noreply,
       socket
       |> assign(:text, text)
       |> assign(:page_title, page_title(socket.assigns.live_action))
       |> assign(:poem, poem)
       |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    poem = Entries.get_poem!(id)
    {:ok, _} = Entries.delete_poem(poem)

    {:noreply, push_redirect(socket, to: Routes.poems_index_path(socket, :index))}
  end

  def handle_event("save", _params, socket) do
    poem_params = %{
      date: socket.assigns.parsed_date,
      text: socket.assigns.parsed_text
    }

    case Entries.create_poem(poem_params) do
      {:ok, _poem} ->
        {:noreply,
         socket
         |> put_flash(:info, "Poem created successfully")
         |> push_redirect(to: Routes.poems_new_path(socket, :new))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, put_flash(socket, :error, "Errors: #{inspect(changeset.errors)}")}
    end
  end

  defp page_title(:show), do: "Show Poem"
  defp page_title(:edit), do: "Edit Poem"
end
