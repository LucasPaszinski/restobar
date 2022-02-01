defmodule Restobar.Supplies.Supply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "supplies" do
    field :description, :string
    field :expires_at, :date
    field :responsible, :string
    field :restaurant, :id

    timestamps()
  end

  @doc false
  def changeset(supply, attrs) do
    supply
    |> cast(attrs, [:description, :responsible, :expires_at])
    |> validate_required([:description, :responsible, :expires_at])
  end
end
