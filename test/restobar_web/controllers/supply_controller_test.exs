defmodule RestobarWeb.SupplyControllerTest do
  use RestobarWeb.ConnCase

  import Restobar.RestaurantsFixtures
  import Restobar.SuppliesFixtures

  alias Restobar.Supplies.Supply

  @create_attrs %{
    description: "some description",
    expires_at: ~D[2022-01-31],
    responsible: "some responsible"
  }
  @update_attrs %{
    description: "some updated description",
    expires_at: ~D[2022-02-01],
    responsible: "some updated responsible"
  }
  @invalid_attrs %{description: nil, expires_at: nil, responsible: nil}

  setup %{conn: conn} do
    [
      conn: put_req_header(conn, "accept", "application/json"),
      restaurant_id: restaurant_fixture(%{}).id
    ]
  end

  describe "index" do
    test "lists all supplies", %{conn: conn, restaurant_id: restaurant_id} do
      conn = get(conn, Routes.restaurant_supply_path(conn, :index, restaurant_id))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create supply" do
    test "renders supply when data is valid", %{conn: conn, restaurant_id: restaurant_id} do
      conn =
        post(conn, Routes.restaurant_supply_path(conn, :create, restaurant_id),
          supply: @create_attrs
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.restaurant_supply_path(conn, :show, restaurant_id, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "expires_at" => "2022-01-31",
               "responsible" => "some responsible"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, restaurant_id: restaurant_id} do
      conn =
        post(conn, Routes.restaurant_supply_path(conn, :create, restaurant_id),
          supply: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update supply" do
    setup [:create_supply]

    test "renders supply when data is valid", %{
      conn: conn,
      restaurant_id: restaurant_id,
      supply: %Supply{id: id} = supply
    } do
      conn =
        put(conn, Routes.restaurant_supply_path(conn, :update, restaurant_id, supply),
          supply: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.restaurant_supply_path(conn, :show, restaurant_id, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "expires_at" => "2022-02-01",
               "responsible" => "some updated responsible"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      restaurant_id: restaurant_id,
      supply: supply
    } do
      conn =
        put(conn, Routes.restaurant_supply_path(conn, :update, restaurant_id, supply),
          supply: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete supply" do
    setup [:create_supply]

    test "deletes chosen supply", %{conn: conn, restaurant_id: restaurant_id, supply: supply} do
      conn = delete(conn, Routes.restaurant_supply_path(conn, :delete, restaurant_id, supply))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.restaurant_supply_path(conn, :show, restaurant_id, supply))
      end
    end
  end

  defp create_supply(%{restaurant_id: restaurant_id}) do
    supply = supply_fixture(%{restaurant_id: restaurant_id})
    %{supply: supply}
  end
end
