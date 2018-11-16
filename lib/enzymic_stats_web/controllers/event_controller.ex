defmodule EnzymicStatsWeb.EventController do
  require Logger
  use EnzymicStatsWeb, :controller

  import Ecto.Query
  alias EnzymicStats.Models.{AdUnitCurrentReport, Event}
  alias EnzymicStats.Repo

  plug :scrub_params, "event" when action in [:create]

  def create(conn, %{"event" => event_params}) do
    Logger.debug "EventController.create"
    params = if Map.has_key?(event_params, "client_data") do
      Map.merge(event_params, %{"client_uid" => EnzymicStats.Helpers.EventHelper.calculate_client_uid(event_params["client_data"])})
    else
      event_params
    end

    changeset = Event.changeset(%Event{}, params)
    if EnzymicStats.Helpers.EventHelper.should_save_event?(event_params), do: Repo.insert(changeset)
    text conn, :ok
  end

  def unlike(conn, %{"unlike" => unlike_params}) do
    current_report = CurrentReport |> Repo.get_by(ad_id: unlike_params["ad_id"])
    new_data = Map.update(current_report.data, "likes", 0,  &(&1 - 1))
    changeset = CurrentReport.changeset(current_report, %{data: new_data})
    Repo.update(changeset)

    ad_unit_current_report = AdUnitCurrentReport
                            |> Repo.get_by(ad_unit_id: unlike_params["ad_unit_id"],
                                           content_type: unlike_params["content_type"],
                                           size: unlike_params["size"])
    new_data = Map.update(ad_unit_current_report.data, "likes", 0,  &(&1 - 1))
    changeset = AdUnitCurrentReport.changeset(ad_unit_current_report, %{data: new_data})
    Repo.update(changeset)

    text conn, :ok
  end
end
