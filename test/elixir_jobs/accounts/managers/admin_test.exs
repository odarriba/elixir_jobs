defmodule ElixirJobs.Accounts.Managers.AdminTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Accounts.Managers.Admin, as: Manager
  alias ElixirJobs.Accounts.Schemas.Admin

  describe "Admin.list_admins/0" do
    test "returns all admins" do
      admin_1 = insert(:admin)
      admin_2 = insert(:admin)

      result = Manager.list_admins()

      assert Enum.any?(result, &(&1.id == admin_1.id))
      assert Enum.any?(result, &(&1.id == admin_2.id))
    end
  end

  describe "Admin.get_admin!/1" do
    test "returns the admin with given id" do
      admin_1 = insert(:admin)
      admin_2 = insert(:admin)

      result = Manager.get_admin!(admin_1.id)
      assert result.id == admin_1.id

      result = Manager.get_admin!(admin_2.id)
      assert result.id == admin_2.id
    end

    test "raises an exception if no admin is found with that ID" do
      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_admin!(Ecto.UUID.generate())
      end
    end
  end

  describe "Admin.get_admin_by_email!/1" do
    test "returns the admin with given id" do
      admin_1 = insert(:admin)
      admin_2 = insert(:admin)

      result = Manager.get_admin_by_email!(admin_1.email)
      assert result.id == admin_1.id

      result = Manager.get_admin_by_email!(admin_2.email)
      assert result.id == admin_2.id
    end

    test "raises an exception if no admin is found with that email" do
      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_admin_by_email!("non-existent-@email.com")
      end
    end
  end

  describe "Admin.create_admin/1" do
    test "with valid data creates an portal" do
      admin_data = params_for(:admin)

      {result, resource} = Manager.create_admin(admin_data)

      assert result == :ok
      assert %Admin{} = resource
      assert %Admin{} = Manager.get_admin!(resource.id)
    end

    test "with invalid data returns error changeset" do
      admin_data = params_for(:admin, email: "")

      {result, resource} = Manager.create_admin(admin_data)

      assert result == :error
      assert %Ecto.Changeset{} = resource
      assert Enum.any?(resource.errors, fn {k, _v} -> k == :email end)
    end
  end

  describe "Admin.update_admin/2" do
    test "with valid data updates the admin" do
      admin = insert(:admin)

      new_admin_data = %{
        email: "test@elixirjobs.net"
      }

      {result, resource} = Manager.update_admin(admin, new_admin_data)

      assert result == :ok
      assert %Admin{} = resource
      refute resource.email == admin.email
      assert resource.email == new_admin_data[:email]
    end

    test "with invalid data returns error changeset" do
      admin = insert(:admin)
      new_admin_data = %{email: ""}

      {result, resource} = Manager.update_admin(admin, new_admin_data)

      assert result == :error
      assert %Ecto.Changeset{} = resource
      assert Enum.any?(resource.errors, fn {k, _v} -> k == :email end)
    end
  end

  describe "Admin.delete_admin/1" do
    test "deletes the admin" do
      admin = insert(:admin)

      assert %Admin{} = Manager.get_admin!(admin.id)
      assert {:ok, admin} = Manager.delete_admin(admin)

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_admin!(admin.id)
      end
    end
  end

  describe "Admin.change_admin/1" do
    test "generates a changeset" do
      admin = insert(:admin)
      assert %Ecto.Changeset{} = Manager.change_admin(admin)
    end
  end
end
