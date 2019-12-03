defmodule HospitalWeb.AppointmentController do
  use HospitalWeb, :controller

  alias Hospital.Record
  alias Hospital.Record.Appointment

  plug :authenticate when action in [:index,:new,:create,:show,:edit,:update,:delete]

  def index(conn, _params) do
    appointments = Record.list_appointments()
    render(conn, "index.html", appointments: appointments)
  end

  def new(conn, _params) do
    changeset = Record.change_appointment(%Appointment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"appointment" => appointment_params}) do
    case Record.create_appointment(appointment_params) do
      {:ok, appointment} ->
        conn
        |> put_flash(:info, "Appointment created successfully.")
        |> redirect(to: Routes.appointment_path(conn, :show, appointment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    appointment = Record.get_appointment!(id)
    render(conn, "show.html", appointment: appointment)
  end

  def edit(conn, %{"id" => id}) do
    appointment = Record.get_appointment!(id)
    changeset = Record.change_appointment(appointment)
    render(conn, "edit.html", appointment: appointment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "appointment" => appointment_params}) do
    appointment = Record.get_appointment!(id)

    case Record.update_appointment(appointment, appointment_params) do
      {:ok, appointment} ->
        conn
        |> put_flash(:info, "Appointment updated successfully.")
        |> redirect(to: Routes.appointment_path(conn, :show, appointment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", appointment: appointment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    appointment = Record.get_appointment!(id)
    {:ok, _appointment} = Record.delete_appointment(appointment)

    conn
    |> put_flash(:info, "Appointment deleted successfully.")
    |> redirect(to: Routes.appointment_path(conn, :index))
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user.id == 2 do
      conn
    else
      conn
      |> put_flash(:error, "Tienes que Iniciar Sesion para aceder a esta pagina y ser Secretaria")
      |> redirect(to: Routes.page_path(conn, :login))
      |> halt()
    end
  end
end
