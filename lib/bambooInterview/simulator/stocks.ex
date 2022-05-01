defmodule  BambooInterview.Simulator.Stocks  do

    

    def simulate_stock_data_api_request() do
        case File.read("stock_demo.json") do
          {:ok, result} ->
            Jason.decode(result)
          {:error, error} ->
            IO.inspect(error)
            []
        end
    end
end