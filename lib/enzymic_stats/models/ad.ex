defmodule EnzymicStats.Models.Ad do
  require Logger
  use Ecto.Schema

  schema "ads" do
    field :ad_unit_id, :integer
    field :status, :integer
  end
end
