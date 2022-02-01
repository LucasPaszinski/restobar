defmodule RestobarWeb.SupplyView do
  use RestobarWeb, :view
  alias RestobarWeb.SupplyView

  def render("index.json", %{supplies: supplies}) do
    %{data: render_many(supplies, SupplyView, "supply.json")}
  end

  def render("show.json", %{supply: supply}) do
    %{data: render_one(supply, SupplyView, "supply.json")}
  end

  def render("supply.json", %{supply: supply}) do
    %{
      id: supply.id,
      description: supply.description,
      responsible: supply.responsible,
      expires_at: supply.expires_at
    }
  end
end
