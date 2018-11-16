defmodule EnzymicStats.Repo.Migrations.AddUniqueIndexToEvents do
  use Ecto.Migration

  def up do
    execute("CREATE UNIQUE INDEX events_unique_index ON events(category, ad_id, date_trunc('hour', inserted_at), client_uid) WHERE client_uid IS NOT NULL")
  end

  def down do
    execute("DROP INDEX events_unique_index")
  end
end
