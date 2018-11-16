defmodule EnzymicStats.Models.Advertiser do
  require Logger
  use Ecto.Schema

  alias EnzymicStats.Models.Campaign

  schema "advertisers" do
    field :time_zone, :string
    has_many :campaigns, Campaign
  end
end
