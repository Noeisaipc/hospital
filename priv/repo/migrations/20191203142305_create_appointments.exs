defmodule Hospital.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :fecha, :date
      add :nombre, :string

      timestamps()
    end
  end
end
