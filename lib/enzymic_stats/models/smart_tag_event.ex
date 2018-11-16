defmodule EnzymicStats.Models.SmartTagEvent do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset

  schema "smart_tag_events" do
    field :uid, :integer
    field :url, :string
    field :url_protocol, :string
    field :ip, :string

    field :page_title, :string
    field :page_description, :string
    field :image_source_1, :string
    field :image_source_2, :string
    field :image_source_3, :string
    field :image_source_4, :string
    field :selectors_data, :map

    field :smart_tag_id, :integer
    field :page_id, :integer

    timestamps(inserted_at: :created_at)
  end

  @required_fields ~w(smart_tag_id uid url)
  @optional_fields ~w(ip page_title page_description image_source_1 image_source_2 image_source_3 image_source_4 selectors_data url_protocol page_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    Logger.debug "SmartTagEvent.changeset"
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
