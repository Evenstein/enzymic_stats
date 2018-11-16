defmodule EnzymicStatsWeb.AdUnitController do
  require Logger
  use EnzymicStatsWeb, :controller

  alias EnzymicStats.Models.{AdUnit, Campaign, Report, AdUnitReport}

  def create(conn, %{"ad_unit" => ad_unit_params}) do
    Logger.debug "AdUnitController.create"
    campaign = Campaign |> Repo.get_by(original_id: ad_unit_params["campaign_id"])
    if campaign == nil do
      campaign = Campaign.changeset(%Campaign{}, %{"original_id" => ad_unit_params["campaign_id"], "advertiser_id" => ad_unit_params["advertiser_id"]})
      Repo.insert(campaign)
    else
      changeset = Campaign.changeset(campaign, %{"advertiser_id" => ad_unit_params["advertiser_id"]})
      Repo.update(changeset)
    end

    ad_unit_params = Map.put(ad_unit_params, "original_id", ad_unit_params["id"])
    ad_unit = AdUnit |> Repo.get_by(original_id: ad_unit_params["original_id"])

    status = if ad_unit == nil do
      ad_unit = AdUnit.changeset(%AdUnit{}, ad_unit_params)
      Repo.insert(ad_unit)
    else
      ad_unit = AdUnit.changeset(ad_unit, ad_unit_params)
      Repo.update(ad_unit)
    end

    case status do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> text(:ok)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EnzymicStatsWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def stats(conn, %{"ids" => ids} = params) do
    Logger.debug "AdUnitController.stats"
    {date_start, date_finish} = EnzymicStats.Helpers.ReportHelper.parse_dates(params)
    ids = ids |> Enum.filter(fn (v) -> v != nil && v != "" end)
    get_ad_unit_stats = fn ad_unit_id ->
      {ad_unit_id, _} = Integer.parse(ad_unit_id)
      report = if (params["source"] == "ad_unit"), do: AdUnitReport, else: Report
      report.get_ad_unit_stats(ad_unit_id, date_start, date_finish) |> Map.put("id", ad_unit_id)
    end
    ad_unit_stats = Enum.map(ids, get_ad_unit_stats)
    render(conn, "show.json", ad_unit_stats: ad_unit_stats)
  end

  def stats_by_ad_units(conn, %{"ids" => ids} = params) do
    {date_start, date_finish} = EnzymicStats.Helpers.ReportHelper.parse_dates(params)
    ids = ids |> Enum.filter(fn (v) -> v != nil && v != "" end)
    get_stats = fn ad_id ->
      {ad_id, _} = Integer.parse(ad_id)
      AdUnitReport.get_ad_unit_size_stats(ad_id, date_start, date_finish)
    end
    stats = Enum.map(ids, get_stats)

    render(conn, "show.json", ad_unit_stats: List.flatten(stats))
  end
end
