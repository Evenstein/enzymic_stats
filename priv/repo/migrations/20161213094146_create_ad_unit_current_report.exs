defmodule EnzymicStats.Repo.Migrations.CreateAdUnitCurrentReport do
  use Ecto.Migration

  def change do
    create table(:ad_unit_current_reports) do
        add :ad_unit_id, :integer
        add :data, :map
        add :size, :integer
        add :content_type, :integer

        timestamps
    end
    create index(:ad_unit_current_reports, [:ad_unit_id, :content_type, :size])

  end
end
