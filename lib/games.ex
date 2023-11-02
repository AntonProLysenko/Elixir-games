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

  def main(_args) do
    player_input = IO.gets(
      "What game would you like to play?
        1. Guessing Game
        2. Rock Paper Scissors
        3. Wordle

        enter 'stop' to exit: \n")

    IO.inspect(player_input, label: "Input")
    game =
      case player_input do
        "1\n" -> elem(Integer.parse(player_input),0)
        "2\n" -> elem(Integer.parse(player_input),0)
        "3\n" -> elem(Integer.parse(player_input),0)
        "stop\n" -> player_input
      end

    case game do
      1 -> play(["--game=1"])
      2 -> play(["--game=2"])
      3 -> play(["--game=3"])
      "stop\n"  -> IO.puts("Stoped!")
    end

  end


  def play(args) do

    {opts, _word, _error} = OptionParser.parse(args, switches: [game: :integer])

    case opts[:game] do
      1 -> Games.GuessingGame.play()
      2 -> Games.RockPaperScissors.play()
      3 -> Games.Worlde.play()
      _ -> IO.inspect("Error #{opts[:game]}")
    end



  end

end
