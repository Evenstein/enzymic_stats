defmodule EnzymicStatsWeb.AdController do
  require Logger
  use EnzymicStatsWeb, :controller

  alias EnzymicStats.{Repo, AppRepo}
  alias EnzymicStats.Models.{Ad, Report}
  import Ecto.Query

  def stats(conn, %{"ids" => ids} = params) do
    Logger.debug "AdController.stats"
    {date_start, date_finish} = EnzymicStats.Helpers.ReportHelper.parse_dates(params)
    ids = ids |> Enum.filter(fn (v) -> v != nil && v != "" end)
    ids =
      if params["type"] == "export_ads" do
        ads_ids = AppRepo.all(from ad in Ad, where: ad.ad_unit_id in ^ids, select: ad.id)
        Repo.all(
          from cr in CurrentReport,
          where: cr.ad_id in ^ads_ids and
          fragment("(not (data)::jsonb @> '{\"impressions\":0}')"),
          select: cr.ad_id
        )
      end

    get_ad_stats = fn ad_id ->
      {ad_id, _} = if is_integer(ad_id), do: {ad_id, ""}, else: Integer.parse(ad_id)
      Report.get_ad_stats(ad_id, date_start, date_finish) |> Map.put("id", ad_id)
    end
    ad_stats = Enum.map(ids, get_ad_stats)

    render(conn, "show.json", ad_stats: ad_stats)
  end
end
