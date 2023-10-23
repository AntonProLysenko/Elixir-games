defmodule Games.GuessingGame do
  def play(ai_choise\\Enum.random(1..10)) do
    player_choise = elem(Integer.parse(IO.gets("Guess a number between 1 and 10: ")),0)
    computer_choise = ai_choise


    cond do
      player_choise < computer_choise -> IO.puts("#{IO.ANSI.red()}Too Low!\n"); IO.puts("#{IO.ANSI.default_color()}Try one more time");play(computer_choise)
      player_choise > computer_choise -> IO.puts("#{IO.ANSI.blue()}Too High!\n"); IO.puts("#{IO.ANSI.default_color()}Try one more time"); play(computer_choise)
      player_choise == computer_choise -> IO.puts("#{IO.ANSI.green()}You Won")
    end


  end
end
