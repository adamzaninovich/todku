defmodule Todku.Entries do
  @moduledoc """
  The Entries context.
  """

  import Ecto.Query, warn: false
  alias Todku.Repo

  alias Todku.Entries.Poems

  @doc """
  Returns the list of poems.

  ## Examples

      iex> list_poems()
      [%Poems{}, ...]

  """
  def list_poems do
    query = from p in Poems, order_by: [desc: p.date]
    Repo.all(query)
  end

  @doc """
  Gets a single poems.

  Raises `Ecto.NoResultsError` if the Poems does not exist.

  ## Examples

      iex> get_poems!(123)
      %Poems{}

      iex> get_poems!(456)
      ** (Ecto.NoResultsError)

  """
  def get_poems!(id), do: Repo.get!(Poems, id)

  @doc """
  Creates a poems.

  ## Examples

      iex> create_poems(%{field: value})
      {:ok, %Poems{}}

      iex> create_poems(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_poems(attrs \\ %{}) do
    %Poems{}
    |> Poems.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a poems.

  ## Examples

      iex> update_poems(poems, %{field: new_value})
      {:ok, %Poems{}}

      iex> update_poems(poems, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_poems(%Poems{} = poems, attrs) do
    poems
    |> Poems.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a poems.

  ## Examples

      iex> delete_poems(poems)
      {:ok, %Poems{}}

      iex> delete_poems(poems)
      {:error, %Ecto.Changeset{}}

  """
  def delete_poems(%Poems{} = poems) do
    Repo.delete(poems)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking poems changes.

  ## Examples

      iex> change_poems(poems)
      %Ecto.Changeset{data: %Poems{}}

  """
  def change_poems(%Poems{} = poems, attrs \\ %{}) do
    Poems.changeset(poems, attrs)
  end
end
