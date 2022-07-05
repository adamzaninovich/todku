defmodule Todku.EntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todku.Entries` context.
  """

  @doc """
  Generate a poem.
  """
  def poem_fixture(attrs \\ %{}) do
    {:ok, poem} =
      attrs
      |> Enum.into(%{
        date: ~D[2022-06-16],
        text:
          "this is just a test<br/>please don&#39;t count the syllables<br/>they might not be right"
      })
      |> Todku.Entries.create_poem()

    poem
  end
end
