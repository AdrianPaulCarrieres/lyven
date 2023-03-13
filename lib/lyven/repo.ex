defmodule Lyven.Repo do
  use Ecto.Repo,
    otp_app: :lyven,
    adapter: Ecto.Adapters.Postgres
end
