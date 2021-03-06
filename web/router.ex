defmodule RezzyWeb.Router do
  use RezzyWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RezzyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/reservations", ReservationController do
      resources "/comments", CommentController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RezzyWeb do
  #   pipe_through :api
  # end
end
