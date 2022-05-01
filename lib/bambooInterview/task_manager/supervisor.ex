defmodule BambooInterview.TaskManager.Supervisor do
    use Supervisor

    def start_link(args) do
        Supervisor.start_link(__MODULE__, [args], name: TaskManager.Supervisor )
    end

    def init([_args]) do
        children = [
            BambooInterview.TaskManager
        ]
        Supervisor.init(children, strategy: :one_for_one)
    end
end