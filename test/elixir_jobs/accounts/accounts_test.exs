defmodule ElixirJobs.AccountsTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Accounts

  describe "admins" do
    alias ElixirJobs.Accounts.Admin

    @valid_attrs %{
      email: "some email",
      password: "123456",
      password_confirmation: "123456",
      name: "some name"
    }
    @update_attrs %{
      email: "some updated email",
      password: "1234567",
      password_confirmation: "1234567",
      name: "some updated name"
    }
    @invalid_attrs %{email: nil, password: nil, password_confirmation: nil, name: nil}

    def admin_fixture(attrs \\ %{}) do
      {:ok, admin} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_admin()

      admin
    end

    test "list_admins/0 returns all admins" do
      admin_fixture()
      assert length(Accounts.list_admins()) == 1
    end

    test "get_admin!/1 returns the admin with given id" do
      admin = admin_fixture()
      assert Accounts.get_admin_by_id!(admin.id).__struct__ == ElixirJobs.Accounts.Admin
    end

    test "create_admin/1 with valid data creates a admin" do
      assert {:ok, %Admin{} = admin} = Accounts.create_admin(@valid_attrs)
      assert admin.email == "some email"
      assert admin.name == "some name"
    end

    test "create_admin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_admin(@invalid_attrs)
    end

    test "update_admin/2 with valid data updates the admin" do
      admin = admin_fixture()
      assert {:ok, admin} = Accounts.update_admin(admin, @update_attrs)
      assert %Admin{} = admin
      assert admin.email == "some updated email"
      assert admin.name == "some updated name"
    end

    # test "update_admin/2 with invalid data returns error changeset" do
    #   admin = admin_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Accounts.update_admin(admin, @invalid_attrs)
    #   assert admin == Accounts.get_admin!(admin.id)
    # end

    test "delete_admin/1 deletes the admin" do
      admin = admin_fixture()
      assert {:ok, %Admin{}} = Accounts.delete_admin(admin)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_admin_by_id!(admin.id) end
    end

    test "change_admin/1 returns a admin changeset" do
      admin = admin_fixture()
      assert %Ecto.Changeset{} = Accounts.change_admin(admin)
    end
  end
end
