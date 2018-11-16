defmodule EnzymicStats.Jobs.Aggregator do
  import EnzymicStats.Jobs.AdEventAggregator
  import EnzymicStats.Jobs.AdUnitEventAggregator

  use Timex

  def process(date \\ Timex.now) do
    date = Timex.format(date, "{ISO:Extended}") |> elem(1)
    update_reports(date)
    update_reports_for_ad_units(date)
  end
end
