defmodule Todku.Repo.Migrations.CreatePoems do
  use Ecto.Migration

  def change do
    create table(:poems) do
      add :date, :date
      add :text, :string

      timestamps()
    end
  end
end
