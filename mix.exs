defmodule ProjectDependencies.Mixfile do
  use Mix.Project

  def project do
    [app: :project_dependencies,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {ProjectDependencies, []},
      applications: applications(Mix.env)]
  end


  def applications(:test) do
    [:hound | applications(:dev)]
  end

  def applications(_) do
    [
      :phoenix, :phoenix_html, :cowboy, :logger, :gettext
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.1.4"},
      {:phoenix_html, "~> 2.4"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.9"},
      {:cowboy, "~> 1.0"},
      {:hound, "~> 0.8", only: :test},
      {:tentacat, "~> 0.2"}
    ]
  end
end
