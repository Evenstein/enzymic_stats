defmodule EnzymicStats.Repo.Migrations.CreateCampaign do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :original_id, :integer

      timestamps
    end
    create index(:campaigns, [:original_id])

  end
end
