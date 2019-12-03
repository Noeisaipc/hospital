defmodule Hospital.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nombre, :string
      add :edad, :integer
      add :tipo, :integer
      add :correo, :string
      add :password, :string

      timestamps()
    end

  end
end
