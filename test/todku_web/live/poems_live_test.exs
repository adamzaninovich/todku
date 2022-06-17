defmodule TodkuWeb.PoemsLiveTest do
  use TodkuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Todku.EntriesFixtures

  @create_attrs %{date: %{day: 13, month: 6, year: 2022}, text: "some text"}
  @update_attrs %{date: %{day: 14, month: 6, year: 2022}, text: "some updated text"}
  @invalid_attrs %{date: %{day: 30, month: 2, year: 2022}, text: nil}

  defp create_poems(_) do
    poems = poems_fixture()
    %{poems: poems}
  end

  describe "Index" do
    setup [:create_poems]

    test "lists all poems", %{conn: conn, poems: poems} do
      {:ok, _index_live, html} = live(conn, Routes.poems_index_path(conn, :index))

      assert html =~ "Listing Poems"
      assert html =~ poems.text
    end

    test "saves new poems", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.poems_index_path(conn, :index))

      assert index_live |> element("a", "New Poems") |> render_click() =~
               "New Poems"

      assert_patch(index_live, Routes.poems_index_path(conn, :new))

      assert index_live
             |> form("#poems-form", poems: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#poems-form", poems: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.poems_index_path(conn, :index))

      assert html =~ "Poems created successfully"
      assert html =~ "some text"
    end

    test "updates poems in listing", %{conn: conn, poems: poems} do
      {:ok, index_live, _html} = live(conn, Routes.poems_index_path(conn, :index))

      assert index_live |> element("#poems-#{poems.id} a", "Edit") |> render_click() =~
               "Edit Poems"

      assert_patch(index_live, Routes.poems_index_path(conn, :edit, poems))

      assert index_live
             |> form("#poems-form", poems: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#poems-form", poems: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.poems_index_path(conn, :index))

      assert html =~ "Poems updated successfully"
      assert html =~ "some updated text"
    end

    test "deletes poems in listing", %{conn: conn, poems: poems} do
      {:ok, index_live, _html} = live(conn, Routes.poems_index_path(conn, :index))

      assert index_live |> element("#poems-#{poems.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#poems-#{poems.id}")
    end
  end

  describe "Show" do
    setup [:create_poems]

    test "displays poems", %{conn: conn, poems: poems} do
      {:ok, _show_live, html} = live(conn, Routes.poems_show_path(conn, :show, poems))

      assert html =~ "Show Poems"
      assert html =~ poems.text
    end

    test "updates poems within modal", %{conn: conn, poems: poems} do
      {:ok, show_live, _html} = live(conn, Routes.poems_show_path(conn, :show, poems))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Poems"

      assert_patch(show_live, Routes.poems_show_path(conn, :edit, poems))

      assert show_live
             |> form("#poems-form", poems: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#poems-form", poems: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.poems_show_path(conn, :show, poems))

      assert html =~ "Poems updated successfully"
      assert html =~ "some updated text"
    end
  end
end
