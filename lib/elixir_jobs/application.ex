defmodule ElixirJobs.Application do
  @moduledoc """
  Main Application module.

  It starts all the processes related to the application in order to boot it up
  and start serving requests.
  """
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      {ElixirJobs.Repo, []},
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirJobs.PubSub},
      # Start the endpoint when the application starts
      {ElixirJobsWeb.Endpoint, []}
      # Start your own worker by calling: ElixirJobs.Worker.start_link(arg1, arg2, arg3)
      # worker(ElixirJobs.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirJobs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirJobsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
