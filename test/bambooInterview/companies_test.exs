defmodule BambooInterview.CompaniesTest do
  use BambooInterview.DataCase

  alias BambooInterview.Companies

  describe "profiles" do
    alias BambooInterview.Companies.Profile

    @valid_attrs %{address: "some address", city: "some city", company_summary: "some company_summary", country: "some country", currency: "some currency", fullTimeEmployees: 42, industry: "some industry", lastUpdated: "some lastUpdated", logo: "some logo", longName: "some longName", market: "some market", marketCap: "some marketCap", name: "some name", open: "some open", phone: "some phone", sector: "some sector", shortName: "some shortName", state: "some state", website: "some website", zip: "some zip"}
    @update_attrs %{address: "some updated address", city: "some updated city", company_summary: "some updated company_summary", country: "some updated country", currency: "some updated currency", fullTimeEmployees: 43, industry: "some updated industry", lastUpdated: "some updated lastUpdated", logo: "some updated logo", longName: "some updated longName", market: "some updated market", marketCap: "some updated marketCap", name: "some updated name", open: "some updated open", phone: "some updated phone", sector: "some updated sector", shortName: "some updated shortName", state: "some updated state", website: "some updated website", zip: "some updated zip"}
    @invalid_attrs %{address: nil, city: nil, company_summary: nil, country: nil, currency: nil, fullTimeEmployees: nil, industry: nil, lastUpdated: nil, logo: nil, longName: nil, market: nil, marketCap: nil, name: nil, open: nil, phone: nil, sector: nil, shortName: nil, state: nil, website: nil, zip: nil}

    def profile_fixture(attrs \\ %{}) do
      {:ok, profile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_profile()

      profile
    end

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Companies.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Companies.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      assert {:ok, %Profile{} = profile} = Companies.create_profile(@valid_attrs)
      assert profile.address == "some address"
      assert profile.city == "some city"
      assert profile.company_summary == "some company_summary"
      assert profile.country == "some country"
      assert profile.currency == "some currency"
      assert profile.fullTimeEmployees == 42
      assert profile.industry == "some industry"
      assert profile.lastUpdated == "some lastUpdated"
      assert profile.logo == "some logo"
      assert profile.longName == "some longName"
      assert profile.market == "some market"
      assert profile.marketCap == "some marketCap"
      assert profile.name == "some name"
      assert profile.open == "some open"
      assert profile.phone == "some phone"
      assert profile.sector == "some sector"
      assert profile.shortName == "some shortName"
      assert profile.state == "some state"
      assert profile.website == "some website"
      assert profile.zip == "some zip"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{} = profile} = Companies.update_profile(profile, @update_attrs)
      assert profile.address == "some updated address"
      assert profile.city == "some updated city"
      assert profile.company_summary == "some updated company_summary"
      assert profile.country == "some updated country"
      assert profile.currency == "some updated currency"
      assert profile.fullTimeEmployees == 43
      assert profile.industry == "some updated industry"
      assert profile.lastUpdated == "some updated lastUpdated"
      assert profile.logo == "some updated logo"
      assert profile.longName == "some updated longName"
      assert profile.market == "some updated market"
      assert profile.marketCap == "some updated marketCap"
      assert profile.name == "some updated name"
      assert profile.open == "some updated open"
      assert profile.phone == "some updated phone"
      assert profile.sector == "some updated sector"
      assert profile.shortName == "some updated shortName"
      assert profile.state == "some updated state"
      assert profile.website == "some updated website"
      assert profile.zip == "some updated zip"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_profile(profile, @invalid_attrs)
      assert profile == Companies.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Companies.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Companies.change_profile(profile)
    end
  end
end
