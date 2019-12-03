defmodule HospitalWeb.PageController do
  use HospitalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  
  def login(conn, _params) do
  	render(conn, "login.html")
  end

  def profile(conn, _params) do
    conn
      |> render("home.html")
  end

end
