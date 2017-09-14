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
end
