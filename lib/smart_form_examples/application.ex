defmodule SmartFormExamples.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SmartFormExamplesWeb.Telemetry,
      # Start the Ecto repository
      SmartFormExamples.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SmartFormExamples.PubSub},
      # Start Finch
      {Finch, name: SmartFormExamples.Finch},
      # Start the Endpoint (http/https)
      SmartFormExamplesWeb.Endpoint
      # Start a worker by calling: SmartFormExamples.Worker.start_link(arg)
      # {SmartFormExamples.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SmartFormExamples.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SmartFormExamplesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
