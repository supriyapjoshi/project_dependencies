use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :project_dependencies, ProjectDependencies.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

config :hound,
  driver: "chrome_driver",
  app_host: "http://localhost",
  app_port: 4001
