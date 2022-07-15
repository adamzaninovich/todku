defmodule TodkuWeb.DownloadController do
  use TodkuWeb, :controller
  import Todku.Entries, only: [list_poems: 0]

  def index(conn, _params) do
    poems =
      list_poems()
      |> Enum.map_join(",\n", fn poem ->
        inspect(%{date: poem.date, text: poem.text})
      end)

    send_download(conn, {:binary, "[#{poems}]"}, filename: "poems.exs")
  end
end
