defmodule Games.RockPaperScissors do
  @variants ["rock", "paper", "scissors"]

  def play do
    IO.puts("-----======#{IO.ANSI.green()} Rock #{IO.ANSI.red()}Paper #{IO.ANSI.blue()}Scissors #{IO.ANSI.default_color}======----- \n \n \n")

    ai_choise = Enum.random(@variants)
    short_player_choise = String.trim(IO.gets("Enter
      r - for rock
      p - for paper
      s - for scissors
      Type your Choise: "))

    player_choise =
      case short_player_choise do
        "stop"-> Games.main(1)
        "r" -> "rock"
        "p" ->"paper"
        "s" -> "scissors"
      end

    IO.inspect(ai_choise, label: "AI chose");

    case {ai_choise,player_choise} do

      {"rock", "paper"} -> IO.puts("#{IO.ANSI.green()}You win!\n #{IO.ANSI.default_color()}#{player_choise} beats #{ai_choise}.");Games.main(1)
      {"paper", "scissors"}-> IO.puts("#{IO.ANSI.green()}You win!\n #{IO.ANSI.default_color()}#{player_choise} beats #{ai_choise}.");Games.main(1)
      {"scissors", "rock"}-> IO.puts("#{IO.ANSI.green()}You win!\n #{IO.ANSI.default_color()}#{player_choise} beats #{ai_choise}.");Games.main(1)

      {"paper", "rock"}-> IO.puts("#{IO.ANSI.red()}You lose!\n#{IO.ANSI.default_color} #{ai_choise} beats #{player_choise}.");Games.main(1)
      {"scissors", "paper"}-> IO.puts("#{IO.ANSI.red()}You lose!\n#{IO.ANSI.default_color} #{ai_choise} beats #{player_choise}.");Games.main(1)
      {"rock", "scissors"}-> IO.puts("#{IO.ANSI.red()}You lose!\n#{IO.ANSI.default_color} #{ai_choise} beats #{player_choise}.");Games.main(1)
       {_, _}-> IO.puts("#{IO.ANSI.blue()}Draw!#{IO.ANSI.default_color}");Games.main(1)
    end

  end
end
