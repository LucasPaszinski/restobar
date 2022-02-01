defmodule RestobarWeb.SupplyController do
  use RestobarWeb, :controller

  alias Restobar.Supplies
  alias Restobar.Supplies.Supply

  action_fallback RestobarWeb.FallbackController

  def index(conn, _params) do
    supplies = Supplies.list_supplies()
    render(conn, "index.json", supplies: supplies)
  end

  def create(conn, %{"supply" => supply_params, "restaurant_id" => restaurant_id}) do
    with {:ok, %Supply{} = supply} <- Supplies.create_supply(supply_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.restaurant_supply_path(conn, :show, restaurant_id, supply))
      |> render("show.json", supply: supply)
    end
  end

  def show(conn, %{"id" => id}) do
    supply = Supplies.get_supply!(id)
    render(conn, "show.json", supply: supply)
  end

  def update(conn, %{"id" => id, "supply" => supply_params}) do
    supply = Supplies.get_supply!(id)

    with {:ok, %Supply{} = supply} <- Supplies.update_supply(supply, supply_params) do
      render(conn, "show.json", supply: supply)
    end
  end

  def delete(conn, %{"id" => id}) do
    supply = Supplies.get_supply!(id)

    with {:ok, %Supply{}} <- Supplies.delete_supply(supply) do
      send_resp(conn, :no_content, "")
    end
  end
end
