defmodule EnzymicStats.AppRepo do
  use Ecto.Repo,
    otp_app: :enzymic_stats,
    adapter: Ecto.Adapters.Postgres
end