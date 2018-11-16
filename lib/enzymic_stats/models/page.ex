defmodule EnzymicStats.Models.Page do
  require Logger
  use Ecto.Schema

  schema "pages" do
    field :url, :string
    field :smart_tag_id, :integer
  end
end
