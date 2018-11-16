defmodule EnzymicStats.Repo.Migrations.CreateAdUnitEvents do
  use Ecto.Migration

  def up do
    create table(:ad_unit_events) do
      add :category, :integer
      add :ad_unit_id, :integer
      add :content_type, :integer
      add :size, :integer
      add :ad_id, :integer
      add :client_data, :jsonb
      add :client_uid, :string

      timestamps
    end
    create index(:ad_unit_events, [:category, :ad_unit_id, :size, :content_type, :inserted_at])
    execute("CREATE UNIQUE INDEX ad_unit_events_unique_index ON ad_unit_events(category, ad_unit_id,
      size, content_type, ad_id, date_trunc('hour', inserted_at), client_uid) WHERE client_uid IS NOT NULL")
  end

  def down do
    drop table(:ad_unit_events)
  end
end
