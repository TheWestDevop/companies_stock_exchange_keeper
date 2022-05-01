defmodule BambooInterview.Services.APIRequest do

  alias BambooInterview.Simulator.Stocks
  
  use GenServer


  def get_new_companies(), do: GenServer.call(__MODULE__, :get_new_companies)

  def start_link(_args) do
    # you may want to register your server with `name: __MODULE__`
    # as a third argument to `start_link`
    GenServer.start_link(__MODULE__, [:ok], name: __MODULE__)
  end

  @impl true
  def init(_args) do
    {:ok, :initial_state}
  end

  @impl true
  def handle_call(:get_new_companies, _from,  state) do
    result = check_for_new_update()
    {:reply, result, state}
  end

  @impl true
  def terminate(reason, _state) do
    # We could write to a file, database etc
    IO.puts(
      "Endpoint to query for latest added companies server terminated because of #{inspect(reason)}"
    )
    :ok
  end

  
  defp check_for_new_update(), do: Stocks.simulate_stock_data_api_request()

end
