defmodule NjausteveWeb.UsersTest do
  @moduledoc false
  use Njausteve.DataCase

  alias Njausteve.Repo
  alias Njausteve.Users
  alias Njausteve.Users.User

  @valid_params %{
    email: "test@example.com",
    password: "secret1234",
    password_confirmation: "secret1234"
  }

  test "create_admin/2" do
    assert {:ok, user} = Users.create_admin(@valid_params)
    assert user.role == "admin"
  end

  test "set_admin_role/1" do
    assert {:ok, user} = Repo.insert(User.changeset(%User{}, @valid_params))
    assert user.role == "user"

    assert {:ok, user} = Users.set_admin_role(user)
    assert user.role == "admin"
  end

  test "is_admin?/1" do
    refute Users.is_admin?(nil)

    assert {:ok, user} = Repo.insert(User.changeset(%User{}, @valid_params))
    refute Users.is_admin?(user)

    assert {:ok, admin} = Users.create_admin(%{@valid_params | email: "test2@example.com"})
    assert Users.is_admin?(admin)
  end

  test "get_user/1" do
    assert {:error, _message} = Users.get_user(email: "")

    assert {:ok, inserted_user} = Repo.insert(User.changeset(%User{}, @valid_params))
    assert {:ok, fetched_user} = Users.get_user(email: inserted_user.email)

    assert fetched_user == inserted_user
  end
end
