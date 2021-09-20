defmodule ElixirJobs.Core do
  @moduledoc """
  The core context
  """

  alias ElixirJobs.Core.Fields
  alias ElixirJobs.Core.Managers

  defdelegate list_offers(opts \\ Keyword.new()), to: Managers.Offer
  defdelegate get_offer!(id, opts \\ Keyword.new()), to: Managers.Offer
  defdelegate get_offer_by_slug!(slug, opts \\ Keyword.new()), to: Managers.Offer
  defdelegate create_offer(attrs), to: Managers.Offer
  defdelegate update_offer(offer, attrs), to: Managers.Offer
  defdelegate publish_offer(offer), to: Managers.Offer
  defdelegate delete_offer(offer), to: Managers.Offer
  defdelegate change_offer(offer), to: Managers.Offer

  defdelegate get_job_places(), to: Fields.JobPlace, as: :available_values
  defdelegate get_job_types(), to: Fields.JobType, as: :available_values
end
