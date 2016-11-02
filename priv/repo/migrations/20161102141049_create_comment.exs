defmodule RezzyWeb.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string, null: false
      add :reservation_id, references(:reservations, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:comments, [:reservation_id])

  end
end
