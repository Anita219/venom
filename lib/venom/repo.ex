defmodule Venom.Repo do
  use Ecto.Repo,
    otp_app: :venom,
    adapter: Ecto.Adapters.Postgres
end
