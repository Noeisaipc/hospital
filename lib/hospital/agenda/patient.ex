defmodule Hospital.Agenda.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :altura, :string
    field :edad, :integer
    field :nombre, :string
    field :peso, :float

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:nombre, :altura, :edad, :peso])
    |> validate_required([:nombre, :altura, :edad, :peso])
  end
end
