defmodule Restobar.SuppliesTest do
  use Restobar.DataCase

  alias Restobar.Supplies

  describe "supplies" do
    alias Restobar.Supplies.Supply

    import Restobar.SuppliesFixtures

    @invalid_attrs %{description: nil, expires_at: nil, responsible: nil}

    test "list_supplies/0 returns all supplies" do
      supply = supply_fixture()
      assert Supplies.list_supplies() == [supply]
    end

    test "get_supply!/1 returns the supply with given id" do
      supply = supply_fixture()
      assert Supplies.get_supply!(supply.id) == supply
    end

    test "create_supply/1 with valid data creates a supply" do
      valid_attrs = %{description: "some description", expires_at: ~D[2022-01-31], responsible: "some responsible"}

      assert {:ok, %Supply{} = supply} = Supplies.create_supply(valid_attrs)
      assert supply.description == "some description"
      assert supply.expires_at == ~D[2022-01-31]
      assert supply.responsible == "some responsible"
    end

    test "create_supply/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supplies.create_supply(@invalid_attrs)
    end

    test "update_supply/2 with valid data updates the supply" do
      supply = supply_fixture()
      update_attrs = %{description: "some updated description", expires_at: ~D[2022-02-01], responsible: "some updated responsible"}

      assert {:ok, %Supply{} = supply} = Supplies.update_supply(supply, update_attrs)
      assert supply.description == "some updated description"
      assert supply.expires_at == ~D[2022-02-01]
      assert supply.responsible == "some updated responsible"
    end

    test "update_supply/2 with invalid data returns error changeset" do
      supply = supply_fixture()
      assert {:error, %Ecto.Changeset{}} = Supplies.update_supply(supply, @invalid_attrs)
      assert supply == Supplies.get_supply!(supply.id)
    end

    test "delete_supply/1 deletes the supply" do
      supply = supply_fixture()
      assert {:ok, %Supply{}} = Supplies.delete_supply(supply)
      assert_raise Ecto.NoResultsError, fn -> Supplies.get_supply!(supply.id) end
    end

    test "change_supply/1 returns a supply changeset" do
      supply = supply_fixture()
      assert %Ecto.Changeset{} = Supplies.change_supply(supply)
    end
  end
end
