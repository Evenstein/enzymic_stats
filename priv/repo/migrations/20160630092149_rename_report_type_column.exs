defmodule EnzymicStats.Repo.Migrations.RenameReportTypeColumn do
  use Ecto.Migration

  def change do
    rename table(:reports), :type, to: :category
    alter table(:reports) do
      add :category_id,  :integer
    end

    create index(:reports, [:category, :category_id])
  end
end
