defmodule Todku.Repo.Migrations.AddSearchToPoems do
  use Ecto.Migration
  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm;",
            "DROP EXTENSION pg_trgm;"

    create index("poems", ["text gin_trgm_ops"],
             name: :poems_text_trgm_index,
             using: "GIN",
             concurrently: true
           )
  end
end
