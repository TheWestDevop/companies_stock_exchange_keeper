defmodule BambooInterviewWeb.NotificationChannel do
  alias BambooInterview.Simulator.Users
  alias BambooInterview.TaskManager
  alias BambooInterview.Scheduler.CompaniesChecker

  use BambooInterviewWeb, :channel

  @event :send_new_company_notification
  def join("join_notification_channel", _param, socket) do
    {:ok, %{"notification" => []}, socket}
  end

  def handle_info(
        {
          CompaniesChecker,
          @event,
          company_details
        },
        socket
      ) do
   IO.inspect("Sending notification to subscribed users...")
    
    Users.find_users_by_category(company_details["category"])
    |> Stream.uniq()
    |> Enum.to_list()
    |> Enum.each(&TaskManager.execute_sliently(fn -> broadcast(socket, "notify_" <> &1["id"], %{
      "message" => "Hi #{&1["name"]}, #{company_details["name"]} added to stock market"
    })end))
    {:noreply, socket}
  end

end
