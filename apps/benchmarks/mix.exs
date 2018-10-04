defmodule Benchmarks.MixProject do
  use Mix.Project

  def project do
    [
      app: :benchmarks,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:sqlite, in_umbrella: true},
      {:postgres, in_umbrella: true},
      {:fst, in_umbrella: true},
      {:bloom, in_umbrella: true},
      {:datasource, in_umbrella: true},
      {:benchee, "~> 0.13", only: :bench}
    ]
  end
end
