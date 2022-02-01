defmodule Restobar.Repo do
  use Ecto.Repo,
    otp_app: :restobar,
    adapter: Ecto.Adapters.Postgres
end
