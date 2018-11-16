defmodule EnzymicStats.Repo.Migrations.AddIpToCountries do
  use Ecto.Migration

  def change do
    create table(:ip_to_countries) do
      add :ip_start, :inet
      add :ip_end, :inet
      add :country, :string
    end
    create index(:ip_to_countries, [:ip_start, :ip_end])
  end
end
