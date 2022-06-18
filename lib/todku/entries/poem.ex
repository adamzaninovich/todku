defmodule Todku.Entries.Poem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "poems" do
    field :date, :date
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(poem, attrs) do
    poem
    |> cast(attrs, [:date, :text])
    |> validate_required([:date, :text])
  end
end
