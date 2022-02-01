defmodule RestobarWeb.SupplyControllerTest do
  use RestobarWeb.ConnCase

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
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all supplies", %{conn: conn} do
      conn = get(conn, Routes.supply_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create supply" do
    test "renders supply when data is valid", %{conn: conn} do
      conn = post(conn, Routes.supply_path(conn, :create), supply: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.supply_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "expires_at" => "2022-01-31",
               "responsible" => "some responsible"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.supply_path(conn, :create), supply: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update supply" do
    setup [:create_supply]

    test "renders supply when data is valid", %{conn: conn, supply: %Supply{id: id} = supply} do
      conn = put(conn, Routes.supply_path(conn, :update, supply), supply: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.supply_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "expires_at" => "2022-02-01",
               "responsible" => "some updated responsible"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, supply: supply} do
      conn = put(conn, Routes.supply_path(conn, :update, supply), supply: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete supply" do
    setup [:create_supply]

    test "deletes chosen supply", %{conn: conn, supply: supply} do
      conn = delete(conn, Routes.supply_path(conn, :delete, supply))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.supply_path(conn, :show, supply))
      end
    end
  end

  defp create_supply(_) do
    supply = supply_fixture()
    %{supply: supply}
  end
end
