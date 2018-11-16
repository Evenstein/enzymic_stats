defmodule EnzymicStats.Repo.Migrations.ChangeUniqueIndexesForEventsAndAdUnitEvents do
  use Ecto.Migration

  def up do
    execute("DROP INDEX events_unique_index")
    execute("DROP INDEX ad_unit_events_unique_index")

    execute("CREATE UNIQUE INDEX events_unique_index ON events(category, ad_id, date_trunc('minute', inserted_at),
      client_uid) WHERE client_uid IS NOT NULL")
    execute("CREATE UNIQUE INDEX ad_unit_events_unique_index ON ad_unit_events(category, ad_unit_id,
      size, content_type, ad_id, date_trunc('minute', inserted_at), client_uid) WHERE client_uid IS NOT NULL")
  end

  def down do
    execute("DROP INDEX events_unique_index")
    execute("DROP INDEX ad_unit_events_unique_index")

    execute("CREATE UNIQUE INDEX events_unique_index ON events(category, ad_id, date_trunc('hour', inserted_at),
      client_uid) WHERE client_uid IS NOT NULL")
    execute("CREATE UNIQUE INDEX ad_unit_events_unique_index ON ad_unit_events(category, ad_unit_id,
      size, content_type, ad_id, date_trunc('hour', inserted_at), client_uid) WHERE client_uid IS NOT NULL")
  end
end
