defmodule Games.GuessingGame do
  def play(ai_choise\\Enum.random(1..10)) do
    IO.puts("\n-----======#{IO.ANSI.yellow()} Guess a Number #{IO.ANSI.default_color()}======----- \n")
    real_players_choise = IO.gets("Guess a number between 1 and 10: ")

    if real_players_choise == "stop\n" do
       Games.main(1)
    end

    player_choise = elem(Integer.parse(real_players_choise),0)
    computer_choise = ai_choise


    cond do
      player_choise < computer_choise -> IO.puts("#{IO.ANSI.red()}Too Low!\n"); IO.puts("#{IO.ANSI.default_color()}Try one more time");play(computer_choise)
      player_choise > computer_choise -> IO.puts("#{IO.ANSI.blue()}Too High!\n"); IO.puts("#{IO.ANSI.default_color()}Try one more time"); play(computer_choise)
      player_choise == computer_choise -> IO.puts("#{IO.ANSI.green()}You Won!#{IO.ANSI.default_color()}"); Games.main(1)
    end


  end
end
