defmodule HospitalWeb.SessionController do
    use HospitalWeb, :controller

    alias Hospital.Accounts
  
    def new(conn, _params) do
        if conn.assigns.current_user do
            conn
            |>redirect(to: Routes.page_path(conn, :softgrafic))
          else
            conn
            |>render conn, "new.html"
        end
    end
    
    def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
        with {:ok, user} <- Accounts.login(user,pass) do
           HospitalWeb.Authentication.login(conn,user)
            |> redirect(to: Routes.page_path(conn, :profile))
          else
            {:error, _} ->
                conn
                |> put_flash(:error, "Invalid username/password") 
                |> redirect(to: Routes.page_path(conn, :login))
        end
    end
    
    def delete(conn, _) do
        conn
        |> HospitalWeb.Authentication.logout()
        |> redirect(to: Routes.page_path(conn, :index))
    end

end