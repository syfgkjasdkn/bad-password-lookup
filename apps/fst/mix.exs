defmodule FST.MixProject do
  use Mix.Project

  def project do
    [
      app: :fst,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler | Mix.compilers()],
      rustler_crates: rustler_crates(),
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
      {:rustler, "~> 0.18", runtime: false, override: true}
    ]
  end

  defp rustler_crates do
    [
      fst_nifs: [
        path: "native/fst_nifs",
        mode: rustc_mode(Mix.env())
      ]
    ]
  end

  defp rustc_mode(env) when env in [:prod, :bench], do: :release
  defp rustc_mode(_env), do: :debug
end
