defmodule EnzymicStats.Repo.Migrations.AddCategoryAdIdInsertedAtIndexToEvents do
  use Ecto.Migration

  def change do
    create index(:events, [:category, :ad_id, :inserted_at])
  end
end
