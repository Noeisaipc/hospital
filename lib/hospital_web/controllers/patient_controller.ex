defmodule HospitalWeb.PatientController do
  use HospitalWeb, :controller

  alias Hospital.Agenda
  alias Hospital.Agenda.Patient

  plug :authenticate when action in [:index,:new,:create,:show,:edit,:update,:delete]

  def index(conn, _params) do
    patients = Agenda.list_patients()
    render(conn, "index.html", patients: patients)
  end

  def new(conn, _params) do
    changeset = Agenda.change_patient(%Patient{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"patient" => patient_params}) do
    case Agenda.create_patient(patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient created successfully.")
        |> redirect(to: Routes.patient_path(conn, :show, patient))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = Agenda.get_patient!(id)
    render(conn, "show.html", patient: patient)
  end

  def edit(conn, %{"id" => id}) do
    patient = Agenda.get_patient!(id)
    changeset = Agenda.change_patient(patient)
    render(conn, "edit.html", patient: patient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Agenda.get_patient!(id)

    case Agenda.update_patient(patient, patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient updated successfully.")
        |> redirect(to: Routes.patient_path(conn, :show, patient))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", patient: patient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Agenda.get_patient!(id)
    {:ok, _patient} = Agenda.delete_patient(patient)

    conn
    |> put_flash(:info, "Patient deleted successfully.")
    |> redirect(to: Routes.patient_path(conn, :index))
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      if conn.assigns.current_user.id == 1 do
        conn
        else
          conn
          |> put_flash(:error, "Tienes que ser Doctor para atender un paciente ")
          |> redirect(to: Routes.page_path(conn, :login))
          |> halt()
      end
    else
      conn
      |> put_flash(:error, "Tienes que Iniciar Sesion ")
      |> redirect(to: Routes.page_path(conn, :login))
      |> halt()
    end
  end

end
