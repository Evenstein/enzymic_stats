defmodule EnzymicEnzymicStats.Repo.Migrations.AddMlEvents do
  use Ecto.Migration

  def change do
    create table(:ml_events) do
      add :event_id, :integer
      add :event_created_at, :utc_datetime
      add :category, :string
      add :ad_id, :integer
      add :ad_unit_id, :integer
      add :day_of_week, :integer
      add :hour_of_day, :integer
      add :ad_unit_size, :string
      add :browser, :string
      add :browser_version, :string
      add :os, :string
      add :os_version, :string
      add :device_type, :string
      add :ip, :string
      add :country, :string
      add :domain_url, :string
      add :cookie, :text
    end
  end
end


