defmodule Todku.Repo.Migrations.AddSearchToPoems do
  use Ecto.Migration
  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    execute """
            ALTER TABLE poems
            ADD COLUMN searchable tsvector
            GENERATED ALWAYS AS (
              to_tsvector('english', coalesce(text, ''))
            ) STORED
            """,
            "ALTER TABLE poems DROP COLUMN searchable"

    create index("poems", ["searchable"],
             name: :poems_searchable_index,
             using: "GIN",
             concurrently: true
           )
  end
end
