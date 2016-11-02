defmodule RezzyWeb.ReservationControllerTest do
  use RezzyWeb.ConnCase

  alias RezzyWeb.Reservation
  @valid_attrs %{email: "some content", name: "some content", quantity: 42, reserved_for: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, reservation_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing reservations"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, reservation_path(conn, :new)
    assert html_response(conn, 200) =~ "New reservation"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, reservation_path(conn, :create), reservation: @valid_attrs
    assert redirected_to(conn) == reservation_path(conn, :index)
    assert Repo.get_by(Reservation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, reservation_path(conn, :create), reservation: @invalid_attrs
    assert html_response(conn, 200) =~ "New reservation"
  end

  test "shows chosen resource", %{conn: conn} do
    reservation = Repo.insert! %Reservation{}
    conn = get conn, reservation_path(conn, :show, reservation)
    assert html_response(conn, 200) =~ "Show reservation"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, reservation_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    reservation = Repo.insert! %Reservation{}
    conn = get conn, reservation_path(conn, :edit, reservation)
    assert html_response(conn, 200) =~ "Edit reservation"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    reservation = Repo.insert! %Reservation{}
    conn = put conn, reservation_path(conn, :update, reservation), reservation: @valid_attrs
    assert redirected_to(conn) == reservation_path(conn, :show, reservation)
    assert Repo.get_by(Reservation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    reservation = Repo.insert! %Reservation{}
    conn = put conn, reservation_path(conn, :update, reservation), reservation: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit reservation"
  end

  test "deletes chosen resource", %{conn: conn} do
    reservation = Repo.insert! %Reservation{}
    conn = delete conn, reservation_path(conn, :delete, reservation)
    assert redirected_to(conn) == reservation_path(conn, :index)
    refute Repo.get(Reservation, reservation.id)
  end
end
