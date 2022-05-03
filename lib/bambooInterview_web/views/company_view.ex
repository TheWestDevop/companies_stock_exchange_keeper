defmodule BambooInterviewWeb.CompanyView do
  use BambooInterviewWeb, :view
  alias BambooInterviewWeb.CompanyView

  def render("index.json", %{companies: companies}) do
    %{
      status: true,
      data: render_many(companies, CompanyView, "company.json")
    }
  end

  def render("show.json", %{company: company}) do
    %{
      status: true,
      data: render_one(company, CompanyView, "company.json")
    }
  end
  
  def render("company.json", %{company: company}) do
    %{
      id: company.id,
      sector: company.sector,
      longBusinessSummary: company.longBusinessSummary,
      website: company.website,
      address: company.address,
      state: company.state,
      country: company.country,
      industry: company.industry,
      symbol: company.symbol,
      logo: company.logo,
      shortName: company.shortName,
      longName: company.longName,
      currency: company.currency,
      marketCap: company.marketCap,
      volume: company.volume,
      category: company.category,
      exchange: company.exchange,
      fiftyTwoWeekHigh: company.fiftyTwoWeekHigh,
      fiftyTwoWeekLow: company.fiftyTwoWeekLow,
      dividendYield: company.dividendYield,
      currentPrice: company.currentPrice,
      city: company.city,
      inserted_at: company.inserted_at,
      updated_at: company.updated_at
    }
  end

  def render("error.json", %{message: message}) do
    %{
      status: false,
      message: message
    }
  end



end
