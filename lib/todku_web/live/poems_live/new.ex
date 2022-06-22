defmodule TodkuWeb.PoemsLive.New do
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
      |> assign(:page_title, "Add Poem")
      |> assign(:parsed_text, "Paste an entry to get started")
      |> assign(:parsed_date, "Pick a date ->")

    {:ok, socket}
  end

  @impl true
  def handle_event("set-password", %{"auth" => %{"password" => password}}, socket) do
    {:noreply, assign(socket, :password, password)}
  end

  def handle_event("save", _params, socket) do
    if authed?(socket.assigns.password) do
      poem_params = %{
        date: socket.assigns.parsed_date,
        text: socket.assigns.parsed_text
      }

      case Entries.create_poem(poem_params) do
        {:ok, _poem} ->
          socket =
            socket
            |> put_flash(:info, "Poem created successfully")
            |> assign(:parsed_text, "Paste an entry to get started")
            |> assign(:parsed_date, "Pick a date ->")

          {:noreply, socket}

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

  def handle_event("set-date", %{"date" => %{"date" => date}}, socket) do
    {:noreply, assign(socket, :parsed_date, date)}
  end

  def handle_event("parse", %{"unparsed" => %{"text" => text}}, socket) do
    {:noreply, assign(socket, :parsed_text, Entries.parse_text(text))}
  end
end
