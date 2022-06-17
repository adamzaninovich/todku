defmodule Todku.EntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todku.Entries` context.
  """

  @doc """
  Generate a poems.
  """
  def poems_fixture(attrs \\ %{}) do
    {:ok, poems} =
      attrs
      |> Enum.into(%{
        date: ~D[2022-06-13],
        text: "some text"
      })
      |> Todku.Entries.create_poems()

    poems
  end
end
