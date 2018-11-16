defmodule EnzymicStats.Repo.Migrations.ChangeCampaignReferenceColumn do
  use Ecto.Migration

  def change do
    drop index(:campaigns, [:original_id])
    create unique_index(:campaigns, [:original_id])

    alter table(:ad_units) do
      remove :campaign_id
      add :campaign_id, references(:campaigns, column: :original_id, on_delete: :nothing)
    end
  end
end
