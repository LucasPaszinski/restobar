defmodule Restobar.Restaurants.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "restaurants" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
