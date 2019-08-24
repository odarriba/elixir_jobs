defmodule ElixirJobs.Accounts.Schemas.AdminTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Accounts.Schemas.Admin
  alias ElixirJobs.Repo

  describe "Admin.changeset/2" do
    test "validates correct data" do
      attrs = params_for(:admin)

      result = Admin.changeset(%Admin{}, attrs)

      assert %Ecto.Changeset{} = result
      assert result.valid?
    end

    required_attrs = [:name, :email, :password, :password_confirmation]

    Enum.each(required_attrs, fn attr ->
      test "validates that #{attr} is required" do
        attrs =
          :admin
          |> params_for()
          |> Map.delete(unquote(attr))

        changeset = Admin.changeset(%Admin{}, attrs)

        refute changeset.valid?
        assert Enum.any?(changeset.errors, &(elem(&1, 0) == unquote(attr)))
      end
    end)

    test "encrypted_password is generated if password is created" do
      attrs = params_for(:admin)

      changeset = Admin.changeset(%Admin{}, attrs)

      assert changeset.valid?
      refute Ecto.Changeset.get_change(changeset, :encrypted_password) == nil

      assert Bcrypt.verify_pass(
               attrs[:password],
               Ecto.Changeset.get_change(changeset, :encrypted_password)
             )
    end

    test "encrypted_password is generated if password is updated" do
      admin = insert(:admin)

      attrs = %{
        password: "mynewpass",
        password_confirmation: "mynewpass"
      }

      changeset = Admin.changeset(admin, attrs)

      assert changeset.valid?
      refute Ecto.Changeset.get_change(changeset, :encrypted_password) == admin.encrypted_password

      assert Bcrypt.verify_pass(
               attrs[:password],
               Ecto.Changeset.get_change(changeset, :encrypted_password)
             )
    end

    test "password is optional when user already has a encrypted one" do
      attrs =
        :admin
        |> params_for()
        |> Map.delete(:password)
        |> Map.delete(:password_confirmation)

      result = Admin.changeset(%Admin{encrypted_password: "supersecrethash"}, attrs)

      assert %Ecto.Changeset{} = result
      assert result.valid?
    end

    test "password_confirmation is required if password is received" do
      attrs =
        :admin
        |> params_for()
        |> Map.delete(:password_confirmation)

      changeset = Admin.changeset(%Admin{encrypted_password: "supersecrethash"}, attrs)

      assert %Ecto.Changeset{} = changeset
      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :password_confirmation))
    end

    test "password_confirmation should match password" do
      attrs = params_for(:admin, password: "123456", password_confirmation: "67890")
      changeset = Admin.changeset(%Admin{}, attrs)

      assert %Ecto.Changeset{} = changeset
      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :password_confirmation))
    end

    test "email should be unique" do
      admin = insert(:admin)
      attrs = params_for(:admin, email: admin.email)

      changeset = Admin.changeset(%Admin{}, attrs)

      assert %Ecto.Changeset{} = changeset
      assert changeset.valid?

      {:error, result} = Repo.insert(changeset)
      refute result.valid?
      assert Enum.any?(result.errors, &(elem(&1, 0) == :email))
    end
  end
end
