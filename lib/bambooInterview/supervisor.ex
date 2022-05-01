defmodule BambooInterview.MainSupervisor do
  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, [args], name: __MODULE__)
  end

  def init([_args]) do
    # import Supervisor.Spec
    children = [
      BambooInterview.Scheduler.Supervisor,
      BambooInterview.Cache.Supervisor,
      {Task.Supervisor, name: BambooInterview.TaskManager.Supervisor},
      BambooInterview.Services.Supervisor
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
