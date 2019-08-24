defmodule ElixirJobs.Accounts.Services.AuthenticateAdminTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Accounts.Schemas.Admin
  alias ElixirJobs.Accounts.Services.AuthenticateAdmin

  describe "AuthenticateAdmin.call/2" do
    test "authenticate admin users" do
      admin = insert(:admin)

      {result, resource} = AuthenticateAdmin.call(admin.email, admin.password)

      assert result == :ok
      assert %Admin{} = resource
      assert resource.id == admin.id
    end

    test "returns error on wrong password" do
      admin = insert(:admin)

      {result, resource} = AuthenticateAdmin.call(admin.email, "wadus")

      assert result == :error
      assert resource == :wrong_credentials
    end

    test "returns error on wrong email" do
      {result, resource} = AuthenticateAdmin.call("invent@email.com", "wadus")

      assert result == :error
      assert resource == :wrong_credentials
    end
  end
end
