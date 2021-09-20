# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirJobs.Repo.insert!(%ElixirJobs.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

ElixirJobs.Accounts.create_admin(%{
  email: "dummy@user.com",
  password: "123456",
  password_confirmation: "123456",
  name: "Dummy Admin"
})
