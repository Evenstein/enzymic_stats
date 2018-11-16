defmodule EnzymicStatsWeb.AdView do
  use EnzymicStatsWeb, :view

  def render("show.json", %{ad_stats: ad_stats}) do
    %{data: render_many(ad_stats, EnzymicStatsWeb.AdView, "ad.json")}
  end

  def render("ad.json", %{ad: ad}) do
    ad
  end
end
