defmodule BambooInterview.Scheduler.CompaniesChecker do
  use GenServer

  alias BambooInterview.Services.APIRequest
  alias BambooInterview.Companies
  alias BambooInterview.TaskManager
  alias BambooInterview.CacheManager
  alias Phoenix.PubSub

  @topic inspect(__MODULE__)
  @event :send_new_company_notification
  @pubsub BambooInterview.PubSub

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # Schedule work to be performed at some point
    subscribe_to_event()

    ping_the_process()
    {:ok, state}
  end

  def handle_info(:check_for_new_companies, state) do
    IO.inspect("Checking for new companies...")

    # Do company check here
    check_for_new_companies()

    # Reschedule once more
    ping_the_process()
    {:noreply, state}
  end

  defp ping_the_process() do
    # # Periodically ping with atom :check_for_new_companies this process In every 30 minutes
    Process.send_after(self(), :check_for_new_companies, 30  * 1000)

    # In 1 minutes for development stage
    # Process.send_after(self(), :check_for_new_companies, 60 * 1000)
  end

  defp check_for_new_companies do
    # Get all new companies from the http endpoint
    case APIRequest.get_new_companies() do
      {:ok, result } ->  process_data(result)
      {:error, error} -> IO.inspect("Error getting new companies with: #{error}")
    end
  end
  
  defp process_data(companies) do
    if !Enum.empty?(companies) do
      companies
      |> Stream.uniq()
      |> Enum.to_list()
      |> Enum.each(&process_each_company_record_into_DB(&1))
    end
  end

  defp process_each_company_record_into_DB(company) do
    TaskManager.execute_sliently(fn ->
      case CacheManager.get(company["symbol"]) do
        nil ->
           Companies.create_profile(company)
           |> publish_event(@event)
        _ -> :ok
      end
    end)
    :ok
  end

  defp subscribe_to_event() do
    PubSub.subscribe(@pubsub, @topic)
    :ok
  end

  defp publish_event({:ok, result}, @event) do
    IO.inspect("Publishing event: #{@event}")
    CacheManager.save(result.symbol, result)
    PubSub.broadcast(@pubsub, @topic, {@topic, @event, result})
  end

  defp publish_event({:error, reason}, @event), do: {:error, reason}
end
