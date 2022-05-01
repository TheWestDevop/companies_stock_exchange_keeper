defmodule BambooInterview.Repo do
  use Ecto.Repo,
    otp_app: :bambooInterview,
    adapter: Ecto.Adapters.Postgres
end
