defmodule BambooInterview.Companies.Profile do
  use Ecto.Schema
  import Ecto.Changeset

      
  @primary_key {:id, :binary_id, autogenerate: true}
  

  schema "companies_profile" do
      field :sector, :string
      field :longBusinessSummary, :string
      field :website, :string
      field :address, :string
      field :state, :string
      field :country, :string
      field :industry, :string
      field :symbol, :string
      field :logo, :string
      field :shortName, :string
      field :longName, :string
      field :currency, :string
      field :marketCap, :decimal
      field :volume, :decimal
      field :category, :string
      field :exchange, :string
      field :fiftyTwoWeekHigh, :float
      field :fiftyTwoWeekLow, :float
      field :dividendYield, :float
      field :currentPrice, :float
      field :city, :string

      timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:sector, :longBusinessSummary, :city, :state, :country, :website, :address, :industry, :shortName, :longName, :volume, :currency, :marketCap, :logo, :symbol, :category, :exchange, :fiftyTwoWeekHigh, :fiftyTwoWeekLow, :dividendYield, :currentPrice])
    |> validate_required([:sector, :longBusinessSummary, :city, :state, :country, :website, :address, :industry, :shortName, :longName, :volume, :currency, :marketCap, :logo, :symbol, :category, :exchange, :fiftyTwoWeekHigh, :fiftyTwoWeekLow, :dividendYield, :currentPrice])
  end
end
