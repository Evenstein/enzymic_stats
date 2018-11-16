defmodule EnzymicStatsWeb.CampaignView do
  use EnzymicStatsWeb, :view

  def render("show.json", %{campaign_stats: campaign_stats}) do
    %{data: render_many(campaign_stats, EnzymicStatsWeb.CampaignView, "campaign.json")}
  end

  def render("campaign.json", %{campaign: campaign}) do
    campaign
  end
end
