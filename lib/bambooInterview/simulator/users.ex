defmodule  BambooInterview.Simulator.Users  do
  
    def find_users_by_category(category) do
        users_data()
        |> Stream.filter(&(&1[:category] == category))
    end

    defp users_data() do
        [
            %{id: 1, name: "John", email: "John@example.com", category: "developer"},
            %{id: 2, name: "Jane", email: "Jane@example.com", category: "developer"},
            %{id: 3, name: "Jack", email: "Jack@example.com", category: "developer"},
            %{id: 4, name: "Jill", email: "Jill@example.com", category: "developer"},
            %{id: 5, name: "Jim", email: "Jim@example.com", category: "developer"},
            %{id: 6, name: "Jenny", email: "Jenny@example.com", category: "developer"},
            %{id: 7, name: "Juan", email: "Juan@example.com", category: "developer"},
            %{id: 8, name: "Mark", email: "Mark@example.com", category: "developer"},
            %{id: 9, name: "Paul", email: "Paul@example.com", category: "developer"},
            %{id: 10, name: "Micheal", email: "Micheal@example.com", category: "developer"},
            %{id: 11, name: "Mary", email: "Mary@example.com", category: "developer"},
            %{id: 12, name: "Mary", email: "Mary@example.com", category: "developer"},
            %{id: 13, name: "Mary", email: "Mary@example.com", category: "developer"},
            %{id: 14, name: "Mary", email: "Mary@example.com", category: "developer"},
            %{id: 15, name: "Mary", email: "Mary@example.com", category: "developer"},
            %{id: 16, name: "Mary", email: "Mary@example.com", category: "developer"},
            %{id: 17, name: "Mary", email: "Mary@example.com", category: "developer"},
            %{id: 18, name: "Mary", email: "Mary@example.com", category: "developer"},
            %{id: 19, name: "Mary", email: "Mary@example.com", category: "developer"},
            %{id: 20, name: "Mary", email: "Mary@example.com", category: "developer"}
        ]
    end
end