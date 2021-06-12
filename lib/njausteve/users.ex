defmodule Njausteve.Users do
  @moduledoc """
  The Users context.
  """
  import Ecto.Query, warn: false
  alias Njausteve.Repo
  alias Njausteve.Users.User

  @type t :: %User{}

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_admin(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "admin"})
    |> Repo.insert()
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.changeset_role(%{role: "admin"})
    |> Repo.update()
  end

  @spec is_admin?(t()) :: boolean()
  def is_admin?(%{role: "admin"}), do: true
  def is_admin?(_any), do: false

  @doc """
  Retrieve a user by email
  """
  @spec get_user(email: email :: String.t()) :: {:error, Ecto.NotFoundError} | {:ok, t()}
  def get_user(email: email) when email in ["", nil], do: {:error, "Email must be a string"}
  def get_user(email: email) when not is_binary(email), do: {:error, "Email must be a string"}

  def get_user(email: email) do
    User
    |> get_user_query(email)
    |> Repo.one()
    |> case do
      nil -> {:error, Ecto.NotFoundError}
      user -> {:ok, user}
    end
  end

  defp get_user_query(query, email) do
    where(query, [u], u.email == ^String.downcase(email))
  end
end
