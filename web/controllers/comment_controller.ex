defmodule RezzyWeb.CommentController do
  use RezzyWeb.Web, :controller

  alias RezzyWeb.{Comment, Reservation}

  def action(conn, _) do
    reservation = Repo.get(Reservation, conn.params["reservation_id"])
    apply(__MODULE__, action_name(conn), [conn, reservation, conn.params])
  end

  def new(conn, reservation, _params) do
    changeset = Comment.changeset(build_assoc(reservation, :comments))
    render(conn, "new.html", changeset: changeset, reservation: reservation)
  end

  def create(conn, reservation, %{"comment" => comment_params}) do
    changeset = Comment.changeset(build_assoc(reservation, :comments), comment_params)
    # changeset = Comment.changeset(%Comment{}, comment_params)
    # changeset = Comment.changeset(%Comment{reservation_id: 100}, comment_params)

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: reservation_path(conn, :show, reservation))
      {:error, changeset} ->
        changeset |> IO.inspect
        render(conn, "new.html", changeset: changeset, reservation: reservation)
    end
  end
end
