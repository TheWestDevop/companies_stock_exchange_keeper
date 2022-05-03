defmodule BambooInterview.Services.InformationPubSub do
    alias Phoenix.PubSub
    alias BambooInterview.TaskManager
  
  
     
  
    @topic "companies_info"
    @pubsub BambooInterview.PubSub
    @event :companies_details
  
    def start_link(_args) do
      # you may want to register your server with `name: __MODULE__`
      # as a third argument to `start_link`
      GenServer.start_link(__MODULE__, [:ok], name: __MODULE__)
    end
  
    @impl true
    def init(_args) do
      subscribe_to_event()
      {:ok, :initial_state}
    end
  
    @impl true
    def terminate(reason, _state) do
      IO.puts("Companies Information pubsub queue server terminated because of #{inspect(reason)}")
      :ok
    end
  
    @impl true
    def handle_info({@topic, @event, company_details}, state) do
       process_companies_details(company_details)
      {:noreply, state}
    end
    
    @spec process_companies_details(map()) :: {atom(), atom()}
    defp process_companies_details(company_details) do
      TaskManager.execute_sliently(fn -> 
        IO.inspect("Consume #{company_details.longName} company stock long name from pubsub event queue...")
        end)
    end
  
 
  

    
    @spec subscribe_to_event() :: atom()
    defp subscribe_to_event() do
      PubSub.subscribe(@pubsub, @topic)
      :ok
    end
    
  end
  