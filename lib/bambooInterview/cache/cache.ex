defmodule BambooInterview.CacheManager do
  use GenServer

  def start_link(_init_args) do
    # you may want to register your server with `name: __MODULE__`
    # as a third argument to `start_link`
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  ## Server API

  @impl true
  def init(_args) do
    :ets.new(:cache, [:set, :public, :named_table, read_concurrency: true, write_concurrency: true])
    {:ok, :initial_state}
  end

  @impl true
  def handle_call({:get, key}, _payload, state) do
    reply = 
      case :ets.lookup(:cache, key)  do
        [] -> nil
        [{_,  value}] -> value
      end
    {:reply, reply, state}
  end

  

  @impl true
  def handle_cast({:delete, key}, state) do
    :ets.delete(:cache, key)
    {:noreply, state}
  end

  @impl true
  def handle_cast({:save, key, value}, state) do
    cache(key, value)
    {:noreply, state}
  end

  @impl true
  def terminate(reason, state) do
    # We could write to a file, database etc
    IO.puts("Cache Manager server terminated because of #{inspect(reason)}")
    inspect(state)
    :ok
  end

  ## Client API

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def delete(key) do
    GenServer.cast(__MODULE__, {:delete, key})
  end

  def save(key, value) do
    GenServer.cast(__MODULE__, {:save, key, value})
  end

  # Helper Function  
  defp delete_previous_cache(key) do
    :ets.delete(:cache, key)
  end

  defp on_cache!(key) do
    case :ets.lookup(:cache, key) do
      [] -> false
      [{_ , _value}] -> true
    end
  end

  defp cache(key, value) do
    case on_cache!(key) do
      true ->
        delete_previous_cache(key)
        :ets.insert(:cache, {key, value})

      false ->
        :ets.insert(:cache, {key, value})
    end
  end
end
