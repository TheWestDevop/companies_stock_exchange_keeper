defmodule BambooInterview.Services.Supervisor do
    use Supervisor

    def start_link(_args) do
        Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
    end

    def init(:ok) do
        children = [
            BambooInterview.Services.APIRequest,
            %{
                id: BambooInterview.Services.EmailNotifyer,
                start: {BambooInterview.Services.EmailNotifyer, :start_link, [%{}]}
              },

        ]
        Supervisor.init(children, strategy: :one_for_one)
    end
end