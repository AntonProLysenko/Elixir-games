defmodule Games do
  @moduledoc """
  Documentation for `Games`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Games.hello()
      :world

  """

   defmodule Score do
    use GenServer
    def start() do
      GenServer.start_link(__MODULE__, 0)
    end

    def get_score(pid) do
      GenServer.call(pid, :get_score)
    end

    def add_points(pid, points) do
      GenServer.cast(pid, {:add_points, points})
    end

    @impl true
    def init(score\\0) do
      {:ok, score}
    end

    @impl true
    def handle_call(:get_score, _from, score) do
      {:reply, score, score}
    end

    @impl true
    def handle_cast({:add_points, points}, score) do
      {:noreply, score+points}
    end
  end

  def main(_args) do
    {:ok, pid} = Score.start()
    IO.puts("\n\n\n\n#{IO.ANSI.blue_background(); IO.ANSI.font_9()}-----======#{IO.ANSI.green()} Welcome #{IO.ANSI.red()}To Anton's #{IO.ANSI.yellow()}Game Pack! #{IO.ANSI.default_color()}======----- \n")
    player_input = IO.gets(
      "\n\nWhat game would you like to play?
        1. Guessing Game
        2. Rock Paper Scissors
        3. Wordle

        enter 'stop' to exit
        enter 'score' to view your corrent score
        ")

    game =
      case player_input do
        "1\n" -> elem(Integer.parse(player_input),0)
        "2\n" -> elem(Integer.parse(player_input),0)
        "3\n" -> elem(Integer.parse(player_input),0)
        "stop\n" -> player_input
      end
      #This was required in the asigment!!!
    case game do
      1 -> play(["--game=1"], pid)
      2 -> play(["--game=2"], pid)
      3 -> play(["--game=3"], pid)
      "stop\n"  -> IO.puts("Stoped!")
    end

  end




  def play(args, pid) do
    #Compleatly useles function, but it was a required in the asigment
    {opts, _word, _error} = OptionParser.parse(args, switches: [game: :integer])
    IO.inspect(pid, label: "pid")
    case opts[:game] do
      1 -> Games.GuessingGame.play()
      2 -> Games.RockPaperScissors.play()
      3 -> Games.Worlde.play()
      _ -> IO.inspect("Error #{opts[:game]}")
    end

  end

end
