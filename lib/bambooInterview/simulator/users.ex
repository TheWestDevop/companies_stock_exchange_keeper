defmodule  BambooInterview.Simulator.Users  do
  
    def find_users_by_category(category) do
        users_data()
        |> Stream.filter(&(&1[:category] == category))
        |> Enum.to_list()
    end

    defp users_data() do
        [
            %{id: 1, name: "John", email: "techbitme@gmail.com", category: "Technology"},
            %{id: 2, name: "Jane", email: "techbitme@gmail.com", category: "Technology"},
            %{id: 3, name: "Jack", email: "techbitme@gmail.com", category: "Technology"},
            %{id: 4, name: "Jill", email: "techbitme@gmail.com", category: "Technology"},
            %{id: 5, name: "Jim", email: "techbitme@gmail.com", category: "Technology"},
            %{id: 6, name: "Jenny", email: "techbitme@gmail.com", category: "Technology"},
            %{id: 7, name: "Juan", email: "techbitme@gmail.com", category: "Real Estate"},
            %{id: 8, name: "Mark", email: "techbitme@gmail.com", category: "Real Estate"},
            %{id: 9, name: "Paul", email: "techbitme@gmail.com", category: "Real Estate"},
            %{id: 10, name: "Micheal", email: "techbitme@gmail.com", category: "Real Estate"},
            %{id: 11, name: "Mary", email: "techbitme@gmail.com", category: "Real Estate"},
            %{id: 12, name: "Daniel", email: "techbitme@gmail.com", category: "Real Estate"},
            %{id: 13, name: "Mark", email: "techbitme@gmail.com", category: "Healthcare"},
            %{id: 14, name: "Fisayo", email: "techbitme@gmail.com", category: "Healthcare"},
            %{id: 15, name: "Israel", email: "techbitme@gmail.com", category: "Healthcare"},
            %{id: 16, name: "Tosin", email: "techbitme@gmail.com", category: "Healthcare"},
            %{id: 17, name: "Femi", email: "techbitme@gmail.com", category: "Healthcare"},
            %{id: 18, name: "Ugo", email: "techbitme@gmail.com", category: "Technology"},
            %{id: 19, name: "Mike", email: "techbitme@gmail.com", category: "Real Estate"},
            %{id: 20, name: "Shola", email: "techbitme@gmail.com", category: "Healthcare"}
        ]
    end
end