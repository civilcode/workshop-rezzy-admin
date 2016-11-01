defmodule RezzyWeb.PageController do
  use RezzyWeb.Web, :controller

  plug :show_it
  plug :assign_subject

  def action(conn, _) do
    conn = assign(conn, :subject, "last")
    apply(__MODULE__, action_name(conn), [conn,
                                          conn.params,
                                          "hello"])
  end

  # Plug.Conn

  def index(conn, _params, "hello") do
    conn
    |> render("index.html")
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def assign_subject(conn, _opts) do
    assign(conn, :subject, "World")
  end

  def show_it(conn, _opts) do
    conn |> IO.inspect
  end
end
