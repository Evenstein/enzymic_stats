defmodule EnzymicStatsWeb.SmartTagEventController do
  require Logger
  use EnzymicStatsWeb, :controller

  alias EnzymicStats.Models.{SmartTagEvent, Page}
  alias EnzymicStats.AppRepo

  plug :scrub_params, "ast_event" when action in [:create]

  def create(conn, %{"ast_event" => event_params}) do
    Logger.debug "SmartTagEventController.create"
    url = String.replace(event_params["url"], ~r/\/?$/, "")
    event_params = %{event_params | "url" => url}
    page = Page |> AppRepo.get_by(smart_tag_id: event_params["smart_tag_id"], url: url)
    event_params =
      if page != nil do
        Map.merge(event_params, %{"page_id" => page.id})
      end
    changeset = SmartTagEvent.changeset(%SmartTagEvent{}, event_params)
    AppRepo.insert(changeset)
    text conn, :ok
  end
end
