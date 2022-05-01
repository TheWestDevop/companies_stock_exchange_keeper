defmodule BambooInterview.Services.EmailNotifyer do
  alias BambooInterview.Simulator.Users
  alias BambooInterview.TaskManager
  alias Phoenix.PubSub



  import Bamboo.Email
   

  @topic "companies_checker"
  @pubsub BambooInterview.PubSub
  @event :send_new_company_notification

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
  def terminate(reason, state) do
    IO.puts("Email notify_subscribers server terminated because of #{inspect(reason)}")
    :ok
  end

  @impl true
  def handle_info({@topic, @event, company_details}, state) do
    notify_subscribers(company_details)
    {:noreply, state}
  end

  defp notify_subscribers(company_details) do
    Users.find_users_by_category(company_details.category)
    |> Stream.uniq()
    |> Enum.to_list()
    |> Enum.each(&TaskManager.execute_sliently(fn -> 
      process_email_notification(&1, company_details) 
      publish_web_socket_event(&1, company_details)
        end)
      )
  end

  defp process_email_notification(user, company_details) do
    
    new_email(
      from: {"Invest Bamboo", "oyeniyiadedayo@gmail.com"},
      to: user.email,
      subject: "New Company Added to Stock Market",
      text_body:
        "Hi #{user.name},\n\nA new company has been added to the stock .\n\nCompany Name: #{company_details.longName}\nCompany Symbol: #{company_details.symbol}\nStock Category: #{company_details.category}\n\nRegards,\nInvest Bamboo"
    )
  end


  defp publish_web_socket_event(user, company_details) do
    BambooInterviewWeb.Endpoint.broadcast("user_notification", "notify_#{user.id}", %{
      "message" =>"Hi #{user.name}, #{company_details.longName} added to stock market"
    })
  end
  
  defp subscribe_to_event() do
    PubSub.subscribe(@pubsub, @topic)
    :ok
  end
  
end
