defmodule Hospital.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :correo, :string
    field :edad, :integer
    field :nombre, :string
    field :password, :string
    field :tipo, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nombre, :edad, :tipo, :correo, :password])
    |> validate_required([:nombre, :edad, :tipo, :correo, :password])
  end
end
