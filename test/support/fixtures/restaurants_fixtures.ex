defmodule Restobar.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Restobar.Restaurants` context.
  """

  @doc """
  Generate a restaurant.
  """
  def restaurant_fixture(attrs \\ %{}) do
    {:ok, restaurant} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> Restobar.Restaurants.create_restaurant()

    restaurant
  end
end
