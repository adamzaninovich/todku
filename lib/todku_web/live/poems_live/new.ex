defmodule TodkuWeb.PoemsLive.New do
  use TodkuWeb, :live_view

  alias Todku.Entries
  alias Todku.Entries.Poems

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Add Poem")
      |> assign(:parsed_text, "Paste an entry to get started")
      |> assign(:parsed_date, "Pick a date ->")

    {:ok, socket}
  end

  def handle_event("save", _params, socket) do
    poem_params = %{
      date: socket.assigns.parsed_date,
      text: socket.assigns.parsed_text
    }

    case Entries.create_poems(poem_params) do
      {:ok, _poems} ->
        {:noreply,
         socket
         |> put_flash(:info, "Poem created successfully")
         |> push_redirect(to: Routes.poems_new_path(socket, :new))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, put_flash(socket, :error, "Errors: #{inspect(changeset.errors)}")}
    end
  end

  def handle_event("set-date", %{"date" => %{"date" => date}}, socket) do
    {:noreply, assign(socket, :parsed_date, date)}
  end

  def handle_event("parse", %{"unparsed" => %{"text" => text}}, socket) do
    text =
      text
      |> String.replace(~r/[<>]/, "")
      |> String.replace("\n", "<br>")
      |> String.replace(~r/.*Anything blocking your progress\?<br>/, "")

    socket =
      socket
      |> assign(:parsed_text, text)

    {:noreply, socket}
  end
end
