defmodule Restobar.SuppliesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Restobar.Supplies` context.
  """

  @doc """
  Generate a supply.
  """
  def supply_fixture(attrs \\ %{}) do
    {:ok, supply} =
      attrs
      |> Enum.into(%{
        description: "some description",
        expires_at: ~D[2022-01-31],
        responsible: "some responsible"
      })
      |> Restobar.Supplies.create_supply()

    supply
  end
end
