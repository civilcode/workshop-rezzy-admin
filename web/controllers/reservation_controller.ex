defmodule RezzyWeb.ReservationController do
  use RezzyWeb.Web, :controller

  alias RezzyWeb.{Reservation, Comment}

  def index(conn, _params) do
    reservations = Repo.all(Reservation)
    render(conn, "index.html", reservations: reservations)
  end

  def new(conn, _params) do
    changeset = Reservation.changeset(%Reservation{comments: [%Comment{}]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reservation" => reservation_params}) do
    changeset = Reservation.changeset(%Reservation{}, reservation_params)

    case Repo.insert(changeset) do
      {:ok, _reservation} ->
        conn
        |> put_flash(:info, "Reservation created successfully.")
        |> redirect(to: reservation_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reservation = Repo.get!(Reservation, id) |> Repo.preload(:comments)
    render(conn, "show.html", reservation: reservation, comments: reservation.comments)
  end

  def edit(conn, %{"id" => id}) do
    reservation = Repo.get!(Reservation, id)
    changeset = Reservation.changeset(reservation)
    render(conn, "edit.html", reservation: reservation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reservation" => reservation_params}) do
    reservation = Repo.get!(Reservation, id)
    changeset = Reservation.changeset(reservation, reservation_params)

    case Repo.update(changeset) do
      {:ok, reservation} ->
        conn
        |> put_flash(:info, "Reservation updated successfully.")
        |> redirect(to: reservation_path(conn, :show, reservation))
      {:error, changeset} ->
        render(conn, "edit.html", reservation: reservation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reservation = Repo.get!(Reservation, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(reservation)

    conn
    |> put_flash(:info, "Reservation deleted successfully.")
    |> redirect(to: reservation_path(conn, :index))
  end
end
