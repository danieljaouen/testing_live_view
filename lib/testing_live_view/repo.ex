defmodule TestingLiveView.Repo do
  use Ecto.Repo,
    otp_app: :testing_live_view,
    adapter: Ecto.Adapters.Postgres
end
