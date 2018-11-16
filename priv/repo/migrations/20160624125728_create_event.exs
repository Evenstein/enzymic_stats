defmodule EnzymicStats.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :type, :string
      add :ad_id, :integer

      timestamps
    end

  end
end
