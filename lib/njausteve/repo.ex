defmodule Njausteve.Repo do
  use Ecto.Repo,
    otp_app: :njausteve,
    adapter: Ecto.Adapters.Postgres
end
