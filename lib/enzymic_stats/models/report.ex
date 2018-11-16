defmodule EnzymicStats.Models.Report do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  use Timex

  import Ecto.Query
  alias EnzymicStats.Repo
  require EnzymicStats.Models.AdUnit
  alias EnzymicStats.Models.{AdUnit, Report}

  schema "reports" do
    field :category, :string
    field :category_id, :integer
    field :date, :naive_datetime #Timex.Ecto.Date
    field :data, :map

    timestamps()
  end

  @required_fields ~w(category category_id date data)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    Logger.debug "Report.changeset"
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def get_or_build_by(params) do
    Logger.debug "Report.get_or_build_by"
#    Logger.debug("#{params}")
    iso_date = params["date"]
    {:ok, i_date} = NaiveDateTime.from_iso8601(iso_date)
    Logger.debug i_date
    case Report |> Repo.get_by(category_id: params["category_id"], category: params["category"], date: i_date) do
      nil ->
        {:insert, changeset(struct(Report, %{}), params)}
      report ->
        {:update, changeset(report, params)}
    end
  end

  def get_campaign_stats(campaign_id, date_start \\ :empty, date_finish \\ :empty) do
    Logger.debug "Report.get_campaign_stats"
    get_stats("campaign", campaign_id, date_start, date_finish)
  end

  def get_ad_unit_stats(ad_unit_id, date_start \\ :empty, date_finish \\ :empty) do
    Logger.debug "Report.get_ad_unit_stats"
    get_stats("ad_unit", ad_unit_id, date_start, date_finish)
  end

  def get_ad_stats(ad_id, date_start \\ :empty, date_finish \\ :empty) do
    Logger.debug "Report.get_ad_stats"
    get_stats("ad", ad_id, date_start, date_finish)
  end

  def get_stats(category, category_id, date_start, date_finish) do
    Logger.debug "Report.get_stats"
    query = Report |> where([r], r.category == ^category and r.category_id == ^category_id) |> order_by(desc: :date) |> limit(1)
    case {date_start, date_finish} do
      {:empty, :empty} ->
        (Repo.one(query) || default).data
      {date_start, :empty} ->
        query_start = query |> where([r], r.date <= ^date_start)
        report1 = Repo.one(query_start) || default
        report2 = Repo.one(query) || default
        diff(report1, report2)
      {:empty, date_finish} ->
        query_finish = query |> where([r], r.date <= ^date_finish)
        (Repo.one(query_finish) || default).data
      {date_start, date_finish} ->
      query_start = query |> where([r], r.date <= ^date_start)
        query_finish = query |> where([r], r.date <= ^date_finish)
        report1 = Repo.one(query_start) || default
        report2 = Repo.one(query_finish) || default
        diff(report1, report2)
    end
  end

  def diff(report1, report2) do
    Logger.debug "Report.diff"
    Enum.map(Map.keys(report1.data), fn key -> {key, report2.data[key] - report1.data[key]} end) |> Enum.into(%{})
  end

  def default do
    Logger.debug "Report.default"
    struct(Report, %{data: AdUnit.event_types})
  end
end
