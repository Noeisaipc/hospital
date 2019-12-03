defmodule Hospital.AccountsTest do
  use Hospital.DataCase

  alias Hospital.Accounts

  describe "users" do
    alias Hospital.Accounts.User

    @valid_attrs %{correo: "some correo", edad: 42, nombre: "some nombre", password: "some password", tipo: 42}
    @update_attrs %{correo: "some updated correo", edad: 43, nombre: "some updated nombre", password: "some updated password", tipo: 43}
    @invalid_attrs %{correo: nil, edad: nil, nombre: nil, password: nil, tipo: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.correo == "some correo"
      assert user.edad == 42
      assert user.nombre == "some nombre"
      assert user.password == "some password"
      assert user.tipo == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.correo == "some updated correo"
      assert user.edad == 43
      assert user.nombre == "some updated nombre"
      assert user.password == "some updated password"
      assert user.tipo == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
