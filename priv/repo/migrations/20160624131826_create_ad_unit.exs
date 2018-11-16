defmodule EnzymicStats.Repo.Migrations.CreateAdUnit do
  use Ecto.Migration

  def change do
    create table(:ad_units) do
      add :ads, {:array, :integer}
      add :campaign_id, references(:campaigns, on_delete: :nothing)
      add :original_id, :integer

      timestamps
    end
    create index(:ad_units, [:campaign_id])
    create index(:ad_units, [:original_id])

  end
end
