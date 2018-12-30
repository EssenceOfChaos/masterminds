defmodule Masterminds.Repo do
  use Ecto.Repo,
    otp_app: :masterminds,
    adapter: Ecto.Adapters.Postgres
end
