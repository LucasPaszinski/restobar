defmodule RestobarWeb.RestaurantView do
  use RestobarWeb, :view
  alias RestobarWeb.RestaurantView

  def render("index.json", %{restaurants: restaurants}) do
    %{data: render_many(restaurants, RestaurantView, "restaurant.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    %{data: render_one(restaurant, RestaurantView, "restaurant.json")}
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    %{
      id: restaurant.id,
      name: restaurant.name,
      email: restaurant.email
    }
  end
end
