defmodule Hospital.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :nombre, :string
      add :altura, :string
      add :edad, :integer
      add :peso, :float

      timestamps()
    end

  end
end
