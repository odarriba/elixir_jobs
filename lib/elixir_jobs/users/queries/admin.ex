defmodule ElixirJobs.Users.Queries.Admin do
  import Ecto.Query, warn: false

  def by_id(query, id) do
    from a in query,
      where: a.id == ^id
  end

  def by_email(query, email) do
    from a in query,
      where: a.email == ^email
  end

  @doc """
  Selects only emails of admins

  ## Examples
    iex>
  """
  def admin_emails(query) do
    from admin in query,
      select: {admin.name, admin.email}
  end

end
