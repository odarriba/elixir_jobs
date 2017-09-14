defmodule ElixirJobs.UsersTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Users

  describe "admins" do
    alias ElixirJobs.Users.Admin

    @valid_attrs %{email: "some email", encrypted_password: "some encrypted_password", name: "some name"}
    @update_attrs %{email: "some updated email", encrypted_password: "some updated encrypted_password", name: "some updated name"}
    @invalid_attrs %{email: nil, encrypted_password: nil, name: nil}

    def admin_fixture(attrs \\ %{}) do
      {:ok, admin} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_admin()

      admin
    end

    test "list_admins/0 returns all admins" do
      admin = admin_fixture()
      assert Users.list_admins() == [admin]
    end

    test "get_admin!/1 returns the admin with given id" do
      admin = admin_fixture()
      assert Users.get_admin!(admin.id) == admin
    end

    test "create_admin/1 with valid data creates a admin" do
      assert {:ok, %Admin{} = admin} = Users.create_admin(@valid_attrs)
      assert admin.email == "some email"
      assert admin.encrypted_password == "some encrypted_password"
      assert admin.name == "some name"
    end

    test "create_admin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_admin(@invalid_attrs)
    end

    test "update_admin/2 with valid data updates the admin" do
      admin = admin_fixture()
      assert {:ok, admin} = Users.update_admin(admin, @update_attrs)
      assert %Admin{} = admin
      assert admin.email == "some updated email"
      assert admin.encrypted_password == "some updated encrypted_password"
      assert admin.name == "some updated name"
    end

    test "update_admin/2 with invalid data returns error changeset" do
      admin = admin_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_admin(admin, @invalid_attrs)
      assert admin == Users.get_admin!(admin.id)
    end

    test "delete_admin/1 deletes the admin" do
      admin = admin_fixture()
      assert {:ok, %Admin{}} = Users.delete_admin(admin)
      assert_raise Ecto.NoResultsError, fn -> Users.get_admin!(admin.id) end
    end

    test "change_admin/1 returns a admin changeset" do
      admin = admin_fixture()
      assert %Ecto.Changeset{} = Users.change_admin(admin)
    end
  end
end
