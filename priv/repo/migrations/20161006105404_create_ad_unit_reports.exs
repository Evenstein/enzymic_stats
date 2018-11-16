defmodule EnzymicStats.Repo.Migrations.CreateAdUnitReports do
  use Ecto.Migration

  def change do
    create table(:ad_unit_reports) do
      add :category, :integer
      add :category_id, :integer
      add :content_type, :integer
      add :size, :integer
      add :date, :date
      add :data, :map

      timestamps
    end
    create index(:ad_unit_reports, [:category, :category_id, :content_type, :size, :date])
  end
end
