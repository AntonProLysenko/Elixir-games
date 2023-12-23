defmodule Games.Score.Application do
  use Application
  @impl true
  def start(_start_type, _start_args) do
    childrens = [
      {Games.Score, 0}
    ]

    opts = [strategy: :one_for_one, name: Score.Supervisor]

    Supervisor.start_link(childrens, opts)
  end

end
