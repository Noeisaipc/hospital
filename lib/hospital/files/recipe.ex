defmodule Hospital.Files.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :fecha, :date
    field :medicamentos, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:fecha, :medicamentos])
    |> validate_required([:fecha, :medicamentos])
  end
end
