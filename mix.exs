defmodule Games.MixProject do
  use Mix.Project

  def project do
    [
      app: :games,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Games],# alows to build an executable file for build run mix.escript.build
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Games.Score.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:faker, "~> 0.17.0"},# Module that genetares random data
      {:ex_doc, "~> 0.29", only: :dev, runtime: false}, # Creates an HTML document from @doc
      {:dialyxir, "~> 1.3", only: :dev, runtime: false}, #provide warnings about your code, such as mismatched types, unreachable code, and other common issues.
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}, #It scans a project's code for anti-patterns and provides suggestions to improve it's quality and readability.
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
