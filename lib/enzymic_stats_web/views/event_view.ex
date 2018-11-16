defmodule EnzymicStatsWeb.EventView do
  use EnzymicStatsWeb, :view

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EnzymicStatsWeb.EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EnzymicStatsWeb.EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      category: event.category,
      ad_id: event.ad_id}
  end
end
