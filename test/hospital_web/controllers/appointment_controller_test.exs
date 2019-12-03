defmodule HospitalWeb.AppointmentControllerTest do
  use HospitalWeb.ConnCase

  alias Hospital.Record

  @create_attrs %{fecha: ~D[2010-04-17]}
  @update_attrs %{fecha: ~D[2011-05-18]}
  @invalid_attrs %{fecha: nil}

  def fixture(:appointment) do
    {:ok, appointment} = Record.create_appointment(@create_attrs)
    appointment
  end

  describe "index" do
    test "lists all appointments", %{conn: conn} do
      conn = get(conn, Routes.appointment_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Appointments"
    end
  end

  describe "new appointment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.appointment_path(conn, :new))
      assert html_response(conn, 200) =~ "New Appointment"
    end
  end

  describe "create appointment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.appointment_path(conn, :create), appointment: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.appointment_path(conn, :show, id)

      conn = get(conn, Routes.appointment_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Appointment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.appointment_path(conn, :create), appointment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Appointment"
    end
  end

  describe "edit appointment" do
    setup [:create_appointment]

    test "renders form for editing chosen appointment", %{conn: conn, appointment: appointment} do
      conn = get(conn, Routes.appointment_path(conn, :edit, appointment))
      assert html_response(conn, 200) =~ "Edit Appointment"
    end
  end

  describe "update appointment" do
    setup [:create_appointment]

    test "redirects when data is valid", %{conn: conn, appointment: appointment} do
      conn = put(conn, Routes.appointment_path(conn, :update, appointment), appointment: @update_attrs)
      assert redirected_to(conn) == Routes.appointment_path(conn, :show, appointment)

      conn = get(conn, Routes.appointment_path(conn, :show, appointment))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, appointment: appointment} do
      conn = put(conn, Routes.appointment_path(conn, :update, appointment), appointment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Appointment"
    end
  end

  describe "delete appointment" do
    setup [:create_appointment]

    test "deletes chosen appointment", %{conn: conn, appointment: appointment} do
      conn = delete(conn, Routes.appointment_path(conn, :delete, appointment))
      assert redirected_to(conn) == Routes.appointment_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.appointment_path(conn, :show, appointment))
      end
    end
  end

  defp create_appointment(_) do
    appointment = fixture(:appointment)
    {:ok, appointment: appointment}
  end
end
