defmodule Games.RockPaperScissors do
  @variants ["rock", "paper", "scissors"]

  def play do
    ai_choise = Enum.random(@variants)
    player_choise = String.trim(IO.gets("Choose [rock, paper,scissors]: "))

    IO.inspect(ai_choise, label: "AI chose");

    case {ai_choise,player_choise} do

      {"rock", "paper"} -> IO.puts("#{IO.ANSI.green()}You win!\n #{IO.ANSI.default_color()}#{player_choise} beats #{ai_choise}.")
      {"paper", "scissors"}-> IO.puts("#{IO.ANSI.green()}You win!\n #{IO.ANSI.default_color()}#{player_choise} beats #{ai_choise}.")
      {"scissors", "rock"}-> IO.puts("#{IO.ANSI.green()}You win!\n #{IO.ANSI.default_color()}#{player_choise} beats #{ai_choise}.")

      {"paper", "rock"}-> IO.puts("#{IO.ANSI.red()}You lose!\n #{IO.ANSI.default_color} #{ai_choise} beats #{player_choise}.")
      {"scissors", "paper"}-> IO.puts("#{IO.ANSI.red()}You lose!\n #{IO.ANSI.default_color} #{ai_choise} beats #{player_choise}.")
      {"rock", "scissors"}-> IO.puts("#{IO.ANSI.red()}You lose!\n #{IO.ANSI.default_color} #{ai_choise} beats #{player_choise}.")
       {_, _}-> IO.puts("#{IO.ANSI.blue()}Draw!")
    end

  end
end
