defmodule EnzymicStats.Repo.Migrations.AddAdvertiserIdToCampaigns do
  use Ecto.Migration

  def change do
    alter table(:campaigns) do
      add :advertiser_id, :integer
    end
  end
end
