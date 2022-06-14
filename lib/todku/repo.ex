defmodule Todku.Repo do
  use Ecto.Repo,
    otp_app: :todku,
    adapter: Ecto.Adapters.Postgres
end
