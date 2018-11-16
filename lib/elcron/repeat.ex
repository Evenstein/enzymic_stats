defmodule Elcron.Repeat do
  use GenServer
  use Timex

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    update_stats() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    EnzymicStats.Jobs.Aggregator.process(Timex.now)
    update_stats() # Reschedule once more
    {:noreply, state}
  end

  defp update_stats() do
    Process.send_after(self(), :work, 1 * 60 * 1000) # In 10 minutes
  end
end
