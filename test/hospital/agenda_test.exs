defmodule Hospital.AgendaTest do
  use Hospital.DataCase

  alias Hospital.Agenda

  describe "patients" do
    alias Hospital.Agenda.Patient

    @valid_attrs %{altura: "some altura", edad: 42, nombre: "some nombre", peso: 120.5}
    @update_attrs %{altura: "some updated altura", edad: 43, nombre: "some updated nombre", peso: 456.7}
    @invalid_attrs %{altura: nil, edad: nil, nombre: nil, peso: nil}

    def patient_fixture(attrs \\ %{}) do
      {:ok, patient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Agenda.create_patient()

      patient
    end

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Agenda.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Agenda.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      assert {:ok, %Patient{} = patient} = Agenda.create_patient(@valid_attrs)
      assert patient.altura == "some altura"
      assert patient.edad == 42
      assert patient.nombre == "some nombre"
      assert patient.peso == 120.5
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agenda.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{} = patient} = Agenda.update_patient(patient, @update_attrs)
      assert patient.altura == "some updated altura"
      assert patient.edad == 43
      assert patient.nombre == "some updated nombre"
      assert patient.peso == 456.7
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Agenda.update_patient(patient, @invalid_attrs)
      assert patient == Agenda.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Agenda.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Agenda.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Agenda.change_patient(patient)
    end
  end
end
