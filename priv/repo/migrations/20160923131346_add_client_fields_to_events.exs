defmodule EnzymicStats.Repo.Migrations.AddClientFieldsToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :client_data, :jsonb
      add :client_uid, :string
    end
  end
end
