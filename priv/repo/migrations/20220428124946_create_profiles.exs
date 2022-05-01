defmodule BambooInterview.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:companies_profile, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :sector, :string
      add :longBusinessSummary, :text
      add :website, :string
      add :address, :string
      add :city, :string
      add :state, :string
      add :country, :string
      add :industry, :string
      add :symbol, :string
      add :logo, :string
      add :shortName, :string
      add :longName, :string
      add :currency, :string
      add :marketCap, :decimal
      add :volume, :decimal
      add :category, :string
      add :exchange, :string
      add :fiftyTwoWeekHigh, :float
      add :fiftyTwoWeekLow, :float
      add :dividendYield, :float
      add :currentPrice, :float
    
      timestamps()
    end

  end
end
