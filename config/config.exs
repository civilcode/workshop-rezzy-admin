# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rezzy_web,
  ecto_repos: [RezzyWeb.Repo]

# Configures the endpoint
config :rezzy_web, RezzyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QlfDTtyvaAI5sZtQxXkm5/t2f3vz6blBRvJ7z46u4Lh/3oq8I2C5dxHI391Udk/B",
  render_errors: [view: RezzyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RezzyWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
