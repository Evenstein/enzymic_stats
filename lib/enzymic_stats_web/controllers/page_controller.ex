defmodule EnzymicStatsWeb.PageController do
  use EnzymicStatsWeb, :controller
  require Logger

  def index(conn, _params) do
    Logger.debug "PageController.index"
    render conn, "index.html"
  end
end
