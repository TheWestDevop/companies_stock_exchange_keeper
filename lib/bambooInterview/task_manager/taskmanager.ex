defmodule BambooInterview.TaskManager do
     
    @spec execute_sliently(fun()) :: atom() 
    def execute_sliently(func) do
        opts = [restart: :transient]
        Task.Supervisor.start_child(BambooInterview.TaskManager.Supervisor,func, opts)
        :ok
    end
end

