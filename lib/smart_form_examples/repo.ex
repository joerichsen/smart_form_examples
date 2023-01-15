defmodule SmartFormExamples.Repo do
  use Ecto.Repo,
    otp_app: :smart_form_examples,
    adapter: Ecto.Adapters.SQLite3
end
