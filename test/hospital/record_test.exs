defmodule Hospital.RecordTest do
  use Hospital.DataCase

  alias Hospital.Record

  describe "appointments" do
    alias Hospital.Record.Appointment

    @valid_attrs %{fecha: ~D[2010-04-17]}
    @update_attrs %{fecha: ~D[2011-05-18]}
    @invalid_attrs %{fecha: nil}

    def appointment_fixture(attrs \\ %{}) do
      {:ok, appointment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Record.create_appointment()

      appointment
    end

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert Record.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert Record.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      assert {:ok, %Appointment{} = appointment} = Record.create_appointment(@valid_attrs)
      assert appointment.fecha == ~D[2010-04-17]
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Record.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{} = appointment} = Record.update_appointment(appointment, @update_attrs)
      assert appointment.fecha == ~D[2011-05-18]
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()
      assert {:error, %Ecto.Changeset{}} = Record.update_appointment(appointment, @invalid_attrs)
      assert appointment == Record.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = Record.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> Record.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = Record.change_appointment(appointment)
    end
  end
end
