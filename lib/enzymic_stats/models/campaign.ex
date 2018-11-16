defmodule EnzymicStats.Models.Campaign do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset

  alias EnzymicStats.Models.{AdUnit, Advertiser}

  schema "campaigns" do
    field :original_id, :integer
    has_many :ad_units, AdUnit, references: :original_id, foreign_key: :campaign_id
    belongs_to :advertiser, Advertiser

    timestamps()
  end

  @required_fields ~w(original_id)
  @optional_fields ~w(advertiser_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    Logger.debug "Campaign.changeset"
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
