defmodule Restobar.Repo.Migrations.CreateSupplies do
  use Ecto.Migration

  def change do
    create table(:supplies) do
      add :description, :string
      add :responsible, :string
      add :expires_at, :date
      add :restaurant, references(:restaurants, on_delete: :nothing)

      timestamps()
    end

    create index(:supplies, [:restaurant])
  end
end
