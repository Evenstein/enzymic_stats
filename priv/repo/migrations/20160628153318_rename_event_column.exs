defmodule EnzymicStats.Repo.Migrations.RenameEventColumn do
  use Ecto.Migration

  def change do
    rename table(:events), :type, to: :category
  end
end
