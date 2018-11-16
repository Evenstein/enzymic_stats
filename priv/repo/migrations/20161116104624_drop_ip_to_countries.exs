defmodule EnzymicStats.Repo.Migrations.DropIpToCountries do
  use Ecto.Migration

  def change do
    drop table(:ip_to_countries)
  end
end
