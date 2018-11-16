defmodule EnzymicStats.Repo.Migrations.CreateReport do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :type, :string
      add :date, :date
      add :data, :map

      timestamps
    end
    create index(:reports, [:date])

  end
end
