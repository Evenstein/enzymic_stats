defmodule EnzymicStatsWeb.AdUnitView do
  use EnzymicStatsWeb, :view

  def render("index.json", %{ad_units: ad_units}) do
    %{data: render_many(ad_units, EnzymicStatsWeb.AdUnitView, "ad_unit.json")}
  end

  def render("show.json", %{ad_unit_stats: ad_unit_stats}) do
    %{data: render_many(ad_unit_stats, EnzymicStatsWeb.AdUnitView, "ad_unit.json")}
  end

  def render("ad_unit.json", %{ad_unit: ad_unit}) do
    ad_unit
  end
end
