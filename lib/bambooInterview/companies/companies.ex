defmodule BambooInterview.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias BambooInterview.Repo

  alias BambooInterview.Companies.Profile

  @doc """
  Returns the list of profiles.

  ## Examples

      iex> list_profiles()
      [%Profile{}, ...]

  """
  def list_profiles do
    Repo.all(Profile)
  end

  @doc """
  Gets a single profile.

  Raises `Ecto.NoResultsError` if the Profile does not exist.

  ## Examples

      iex> get_profile!(123)
      %Profile{}

      iex> get_profile!(456)
      ** (Ecto.NoResultsError)

  """
  def get_profile!(id), do: Repo.get!(Profile, id)

  def get_companies_by_date(start_date, end_date) do
    {:ok, start_date} = NaiveDateTime.new(start_date, ~T[00:00:53])
    {:ok, end_date} = NaiveDateTime.new(end_date, ~T[23:00:00])

    query =
      from(a in Profile,
        where:
          a.inserted_at >= ^start_date and
            a.inserted_at <= ^end_date
      )

    Repo.all(query)
  end

  @doc """
  Creates a profile.

  ## Examples

      iex> create_profile(%{field: value})
      {:ok, %Profile{}}

      iex> create_profile(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_profile(attrs \\ %{}) do
    case is_company_exist?(attrs["shortName"]) do
      true ->
        {:error, "company already exist"}

      false ->
        %Profile{}
        |> Profile.changeset(attrs)
        |> Repo.insert()
    end
  end

  @doc """
  Updates a profile.

  ## Examples

      iex> update_profile(profile, %{field: new_value})
      {:ok, %Profile{}}

      iex> update_profile(profile, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_profile(%Profile{} = profile, attrs) do
    profile
    |> Profile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a profile.

  ## Examples

      iex> delete_profile(profile)
      {:ok, %Profile{}}

      iex> delete_profile(profile)
      {:error, %Ecto.Changeset{}}

  """
  def delete_profile(%Profile{} = profile) do
    Repo.delete(profile)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking profile changes.

  ## Examples

      iex> change_profile(profile)
      %Ecto.Changeset{data: %Profile{}}

  """
  def change_profile(%Profile{} = profile, attrs \\ %{}) do
    Profile.changeset(profile, attrs)
  end

  @spec is_company_exist?(String.t()) :: boolean()
  defp is_company_exist?(key) do
    query =
      from(a in Profile,
        where: a.shortName == ^key
      )

    Repo.exists?(query)
  end
end
