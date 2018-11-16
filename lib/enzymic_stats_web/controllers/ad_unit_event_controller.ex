defmodule EnzymicStatsWeb.AdUnitEventController do
  require Logger
  use EnzymicStatsWeb, :controller

  alias EnzymicStats.Models.AdUnitEvent
  alias EnzymicStats.Repo

  plug :scrub_params, "event" when action in [:create]

  def create(conn, %{"event" => event_params}) do
    Logger.debug "EventController.create"
    params = if Map.has_key?(event_params, "client_data") do
      Map.merge(event_params, %{"client_uid" => EnzymicStats.Helpers.EventHelper.calculate_client_uid(event_params["client_data"])})
    else
      event_params
    end

    changeset = AdUnitEvent.changeset(%AdUnitEvent{}, params)
    if EnzymicStats.Helpers.EventHelper.should_save_event?(event_params), do: Repo.insert(changeset)
    text conn, :ok
  end
end
