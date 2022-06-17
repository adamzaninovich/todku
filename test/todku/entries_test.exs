defmodule Todku.EntriesTest do
  use Todku.DataCase

  alias Todku.Entries

  describe "poems" do
    alias Todku.Entries.Poems

    import Todku.EntriesFixtures

    @invalid_attrs %{date: nil, text: nil}

    test "list_poems/0 returns all poems" do
      poems = poems_fixture()
      assert Entries.list_poems() == [poems]
    end

    test "get_poems!/1 returns the poems with given id" do
      poems = poems_fixture()
      assert Entries.get_poems!(poems.id) == poems
    end

    test "create_poems/1 with valid data creates a poems" do
      valid_attrs = %{date: ~D[2022-06-13], text: "some text"}

      assert {:ok, %Poems{} = poems} = Entries.create_poems(valid_attrs)
      assert poems.date == ~D[2022-06-13]
      assert poems.text == "some text"
    end

    test "create_poems/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entries.create_poems(@invalid_attrs)
    end

    test "update_poems/2 with valid data updates the poems" do
      poems = poems_fixture()
      update_attrs = %{date: ~D[2022-06-14], text: "some updated text"}

      assert {:ok, %Poems{} = poems} = Entries.update_poems(poems, update_attrs)
      assert poems.date == ~D[2022-06-14]
      assert poems.text == "some updated text"
    end

    test "update_poems/2 with invalid data returns error changeset" do
      poems = poems_fixture()
      assert {:error, %Ecto.Changeset{}} = Entries.update_poems(poems, @invalid_attrs)
      assert poems == Entries.get_poems!(poems.id)
    end

    test "delete_poems/1 deletes the poems" do
      poems = poems_fixture()
      assert {:ok, %Poems{}} = Entries.delete_poems(poems)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_poems!(poems.id) end
    end

    test "change_poems/1 returns a poems changeset" do
      poems = poems_fixture()
      assert %Ecto.Changeset{} = Entries.change_poems(poems)
    end
  end
end
