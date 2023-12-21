defmodule Games.GuessingGame do
  def play(ai_choise\\Enum.random(1..10), pid) do
    IO.puts("\n-----======#{IO.ANSI.yellow()} Guess a Number #{IO.ANSI.default_color()}======----- \n")
    real_players_choise = IO.gets("Guess a number between 1 and 10: ")

    if real_players_choise == "stop\n" do
       Games.main(pid)
    end

    player_choise = elem(Integer.parse(real_players_choise),0)
    computer_choise = ai_choise
    IO.puts(computer_choise)


    cond do
      player_choise < computer_choise -> IO.puts("#{IO.ANSI.red()}Too Low!\n"); IO.puts("#{IO.ANSI.default_color()}Try one more time");play(computer_choise, pid)
      player_choise > computer_choise -> IO.puts("#{IO.ANSI.blue()}Too High!\n"); IO.puts("#{IO.ANSI.default_color()}Try one more time"); play(computer_choise, pid)
      player_choise == computer_choise -> IO.puts("#{IO.ANSI.green()}You Won!#{IO.ANSI.default_color()}"); Games.Score.add_points(pid, 5); Games.main(pid);
    end


  end
end
