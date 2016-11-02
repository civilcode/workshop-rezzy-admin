defmodule RezzyWeb.Repo.Migrations.CreateReservation do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :reserved_for, :date
      add :name, :string
      add :email, :string
      add :quantity, :integer

      timestamps()
    end

  end
end
