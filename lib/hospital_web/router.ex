defmodule HospitalWeb.Router do
  use HospitalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HospitalWeb.Authentication
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HospitalWeb do
    pipe_through :browser

    get "/", PageController, :login
    get "/profile", PageController, :profile
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/users", UserController
    resources "/patients", PatientController
    resources "/appointments", AppointmentController
    resources "/recipes", RecipeController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HospitalWeb do
  #   pipe_through :api
  # end
end
