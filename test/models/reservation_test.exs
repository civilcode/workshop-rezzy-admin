defmodule RezzyWeb.ReservationTest do
  use RezzyWeb.ModelCase

  alias RezzyWeb.Reservation

  @valid_attrs %{email: "some content", name: "some content", quantity: 42, reserved_for: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Reservation.changeset(%Reservation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Reservation.changeset(%Reservation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
