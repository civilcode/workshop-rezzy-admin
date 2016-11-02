defmodule RezzyWeb.Reservation do
  use RezzyWeb.Web, :model

  schema "reservations" do
    field :reserved_for, Ecto.Date
    field :name, :string
    field :email, :string
    field :quantity, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:reserved_for, :name, :email, :quantity])
    |> validate_required([:reserved_for, :name, :email, :quantity])
  end
end