defmodule BambooInterviewWeb.CompanyController do
  use BambooInterviewWeb, :controller

  alias BambooInterview.Companies

  action_fallback(BambooInterviewWeb.FallbackController)

  def index(conn, %{
        "start_date" => start_date,
        "end_date" => end_date,
        "filter_by_date" => filter_by_date
      }) do
    if  to_boolean(filter_by_date)  do
      filter(conn, start_date, end_date)
    else
      companies = Companies.list_profiles()
      render(conn, "index.json", companies: companies)
    end
  end

  defp filter(conn, start_date, end_date) do
    if is_valid?(start_date) && is_valid?(end_date) do
      case format_date(start_date) do
        {:ok, formatted_start_date} ->
          case format_date(end_date) do
            {:ok, formatted_end_date} ->
              companies =
                Companies.get_companies_by_date(formatted_start_date, formatted_end_date)

              render(conn, "index.json", companies: companies)

            {:error, _} ->
              render(conn, "error.json", %{message: "Invalid End Date"})
          end

        {:error, _} ->
          render(conn, "error.json", %{message: "Invalid Start Date"})
      end
    else
      render(conn, "error.json", %{message: "Invalid Date"})
    end
  end

  @spec is_valid?(String.t()) :: boolean()
  defp is_valid?(value) do
    value
    |> String.trim()
    |> String.contains?("-")
  end

  
  @spec format_date(String.t()) :: {:ok, Date.t()} | {:error, atom()}
  defp format_date(val), do: Date.from_iso8601(val)
  
  @spec to_boolean(String.t()) :: boolean()
  defp to_boolean(val) do
    case String.trim(val) do
      "true" -> true
      "True" -> true
      "false" -> false
      "False" -> false
      _ -> false
    end
  end
  


end
