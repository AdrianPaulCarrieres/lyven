defmodule Lyven.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LyvenWeb.Telemetry,
      # Start the Ecto repository
      Lyven.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lyven.PubSub},
      # Start Finch
      {Finch, name: Lyven.Finch},
      # Start the Endpoint (http/https)
      LyvenWeb.Endpoint
      # Start a worker by calling: Lyven.Worker.start_link(arg)
      # {Lyven.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lyven.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LyvenWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
