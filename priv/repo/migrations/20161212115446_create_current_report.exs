defmodule EnzymicStats.Repo.Migrations.CreateCurrentReport do
  use Ecto.Migration

  def change do
    create table(:current_reports) do
      add :data, :map
      add :ad_id, :integer

      timestamps
    end
    create index(:current_reports, [:ad_id])

  end
end
