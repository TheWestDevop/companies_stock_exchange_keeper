defmodule  BambooInterview.Simulator.Users  do
   
    @spec find_users_by_category(String.t()) :: [map()] | []
    def find_users_by_category(category) do
        users_data()
        |> Stream.filter(&(&1[:category] == category))
        |> Enum.to_list()
    end
     
    @spec users_data() :: [map()] | []
    defp users_data() do
        [
            %{id: 1, name: "John", email: "techbitme@gmail.com", category: "Technology"},
            %{id: 2, name: "Jane", email: "techbitme2@gmail.com", category: "Technology"},
            %{id: 3, name: "Jack", email: "techbitme3@gmail.com", category: "Technology"},
            %{id: 4, name: "Jill", email: "techbitme4@gmail.com", category: "Technology"},
            %{id: 5, name: "Jim", email: "techbitme5@gmail.com", category: "Technology"},
            %{id: 6, name: "Jenny", email: "techbitm6e@gmail.com", category: "Technology"},
            %{id: 7, name: "Juan", email: "techbitme7@gmail.com", category: "Real Estate"},
            %{id: 8, name: "Mark", email: "techbitme8@gmail.com", category: "Real Estate"},
            %{id: 9, name: "Paul", email: "techbitme9@gmail.com", category: "Real Estate"},
            %{id: 10, name: "Micheal", email: "techbitme10@gmail.com", category: "Real Estate"},
            %{id: 11, name: "Mary", email: "techbitme11@gmail.com", category: "Real Estate"},
            %{id: 12, name: "Daniel", email: "techbitme12@gmail.com", category: "Real Estate"},
            %{id: 13, name: "Mark", email: "techbitme13@gmail.com", category: "Healthcare"},
            %{id: 14, name: "Fisayo", email: "techbitme14@gmail.com", category: "Healthcare"},
            %{id: 15, name: "Israel", email: "techbitme15@gmail.com", category: "Healthcare"},
            %{id: 16, name: "Tosin", email: "techbitme16@gmail.com", category: "Healthcare"},
            %{id: 17, name: "Femi", email: "techbitme17@gmail.com", category: "Healthcare"},
            %{id: 18, name: "Ugo", email: "techbitme18@gmail.com", category: "Technology"},
            %{id: 19, name: "Mike", email: "techbitme19@gmail.com", category: "Real Estate"},
            %{id: 20, name: "Shola", email: "techbitme20@gmail.com", category: "Healthcare"}
        ]
    end
end