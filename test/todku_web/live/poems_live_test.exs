defmodule TodkuWeb.PoemsLiveTest do
  use TodkuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Todku.EntriesFixtures

  @create_attrs %{date: %{day: 13, month: 6, year: 2022}, text: "some text"}
  @update_attrs %{date: %{day: 14, month: 6, year: 2022}, text: "some updated text"}
  @invalid_attrs %{date: %{day: 30, month: 2, year: 2022}, text: nil}

  defp create_poem(_) do
    poem = poem_fixture()
    %{poem: poem}
  end

  describe "Index" do
    setup [:create_poem]

    test "lists all poems", %{conn: conn, poem: poem} do
      {:ok, _index_live, html} = live(conn, Routes.poems_index_path(conn, :index))

      assert html =~ "Listing Poems"
      assert html =~ poem.text
    end

    # test "saves new poem", %{conn: conn} do
    #   {:ok, index_live, _html} = live(conn, Routes.poems_index_path(conn, :index))

    #   assert index_live |> element("a", "Add poem") |> render_click() =~
    #            "Add Poem from Slack"

    #   assert_patch(index_live, Routes.poems_index_path(conn, :new))

    #   assert index_live
    #          |> form("#poem-form", poem: @invalid_attrs)
    #          |> render_change() =~ "is invalid"

    #   {:ok, _, html} =
    #     index_live
    #     |> form("#poem-form", poem: @create_attrs)
    #     |> render_submit()
    #     |> follow_redirect(conn, Routes.poems_index_path(conn, :index))

    #   assert html =~ "Poems created successfully"
    #   assert html =~ "some text"
    # end
  end

  describe "Show" do
    setup [:create_poem]

    test "displays poems", %{conn: conn, poem: poem} do
      {:ok, _show_live, html} = live(conn, Routes.poems_show_path(conn, :show, poem))

      assert html =~ poem.text
    end
  end
end
