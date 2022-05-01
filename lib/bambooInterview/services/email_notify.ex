defmodule BambooInterview.Services.EmailNotifyer do
  alias BambooInterview.Simulator.Users
  alias BambooInterview.TaskManager
  alias BambooInterview.Scheduler.CompaniesChecker


  import Bamboo.Email
   

  @topic :companies_checker
  @event :send_new_company_notification
  

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
  def terminate(reason, state) do
    IO.puts("Email notify_subscribers server terminated because of #{inspect(reason)}")
    :ok
  end

  @impl true
  def handle_info({CompaniesChecker, @event, company_details}, state) do
    notify_subscribers(company_details)
    {:noreply, state}
  end

  defp notify_subscribers(company_details) do
    Users.find_users_by_category(company_details[:category])
    |> Stream.uniq()
    |> Enum.to_list()
    |> Enum.each(&TaskManager.execute_sliently(fn -> process_email_notification(&1, company_details) end))
  end

  defp process_email_notification(user, _company_details) do
    IO.inspect("Sending email notification to #{user["email"]}")
    # new_email(
    #   from: {"Invest Bamboo", "oyeniyiadedayo@gmail.com"},
    #   to: user[:email],
    #   subject: "New Company Added to Stock Market",
    #   text_body:
    #     "Hi #{user[:name]},\n\nA new company has been added to the stock .\n\nCompany Name: #{company_details[:name]}\nCompany Symbol: #{company_details[:symbol]}\nStock Category: #{company_details[:category]}\n\nRegards,\nInvest Bamboo"
    # )
  end

  
end
