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
      GenServer.start_link(__MODULE__, arg)
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
      new_score = score+points
      {:noreply, new_score}
    end
  end




  def main(state\\[]) do
    Games.run(state)
  end

  #state used for determining if the game launced first time or not
  # if state is not [] than it is not the first launch
  # [] is a default state provided by escript so I had to use [] instead of any other
  def run(state\\[]) do
    #Starting score process
    {:ok, pid}  =
      if state == [] do
        IO.puts("\n\n\n\n#{IO.ANSI.blue_background(); IO.ANSI.font_9()}-----======#{IO.ANSI.green()} Welcome #{IO.ANSI.red()}To Anton's #{IO.ANSI.yellow()}Game Pack! #{IO.ANSI.default_color()}======----- \n\n")
        Score.start_link(0)
      else
        # IO.puts("Not starting State")
        {:ok, state}
      end

    # IO.puts("\n\n\n\n#{IO.ANSI.blue_background(); IO.ANSI.font_9()}-----======#{IO.ANSI.green()} Welcome #{IO.ANSI.red()}To Anton's #{IO.ANSI.yellow()}Game Pack! #{IO.ANSI.default_color()}======----- \n")

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
      "4\n" -> Games.Score.add_points(pid, 1000); Games.Score.get_score(pid); #Games.main(pid)
      "stop\n" -> IO.puts("Stoped!")
      "score\n" -> IO.puts("\n==============================================\n Your Score is #{Games.Score.get_score(pid)}\n=============================================="); Games.main(pid)
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
