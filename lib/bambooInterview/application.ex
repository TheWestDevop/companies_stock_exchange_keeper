defmodule BambooInterview.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BambooInterview.Repo,
      # Start the Telemetry supervisor
      BambooInterviewWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BambooInterview.PubSub},
      # Start the Endpoint (http/https)
      BambooInterviewWeb.Endpoint,
      # Start a worker by calling: BambooInterview.Worker.start_link(arg)
      # {BambooInterview.Worker, arg}

      # Start the main supervisor for child supervisors
      BambooInterview.MainSupervisor,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BambooInterview.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BambooInterviewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
