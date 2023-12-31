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
    #Calculates and stores a score
    use GenServer
    def start_link(arg\\0) do
      GenServer.start_link(__MODULE__, arg, name: __MODULE__)
    end

    def get_score() do
      GenServer.call(__MODULE__, :get_score)
    end

    def add_points(points) do
      GenServer.cast(__MODULE__, {:add_points, points})
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
      new_score = score+points
      {:noreply, new_score}
    end
  end




  def main(starter_counter\\[]) do
  #state used for determining if the game launced first time or not
  # if state is not [] than it is not the first launch
  # [] is a default state provided by escript so I had to use [] instead of any other

    #Tracking if game just launched or not
   pid  =
      if starter_counter == [] do
        IO.puts("\n\n\n\n#{IO.ANSI.blue_background(); IO.ANSI.font_9()}-----======#{IO.ANSI.green()} Welcome #{IO.ANSI.red()}To Anton's #{IO.ANSI.yellow()}Game Pack! #{IO.ANSI.default_color()}======----- \n\n")
        false
      else
        starter_counter
      end



    player_input = IO.gets(
      "\nWhat game would you like to play?
        1. Guessing Game
        2. Rock Paper Scissors
        3. Wordle

        enter 'stop' to exit
        enter 'score' to view your corrent score
        ")
    #This was required in the asigment!!!
    case player_input do
      "1\n" -> play(["--game=1"], pid)
      "2\n" -> play(["--game=2"], pid)
      "3\n" -> play(["--game=3"], pid)
      "4\n" -> Games.Score.add_points(1000); Games.Score.get_score(); #Games.main(pid)
      "stop\n" -> IO.puts("\n\n\n\n#{IO.ANSI.blue_background(); IO.ANSI.font_9()}-----======#{IO.ANSI.green()} Thank you #{IO.ANSI.red()}for Playing  Anton's #{IO.ANSI.yellow()}Game Pack! #{IO.ANSI.default_color()}======----- \n Good bye!")
      "score\n" -> IO.puts("\n==============================================\n Your Score is #{Games.Score.get_score()}\n=============================================="); Games.main(pid)
    end

  end




  def play(args, pid) do
    #Compleatly useles function, but it was a required in the asigment
    {opts, _word, _error} = OptionParser.parse(args, switches: [game: :integer])
    case opts[:game] do
      1 -> Games.GuessingGame.play(pid)
      2 -> Games.RockPaperScissors.play(pid)
      3 -> Games.Worlde.play(pid)
      _ -> IO.inspect("Error #{opts[:game]}")
    end

  end

end
