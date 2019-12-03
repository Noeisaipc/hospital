defmodule Hospital.Record.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :fecha, :date
    field :nombre, :string

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:fecha])
    |> validate_required([:fecha])
  end
end
