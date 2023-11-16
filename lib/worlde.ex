defmodule Games.Worlde do
  @moduledoc """
  Game where user has to guess a 5-char generated string

  User has 6 tries before the game is over
  """
  @lifes 6

  @doc """
  gets a user's gues from the console and checks if it has exactly 5 chars

  ##Examples
      # iex> get_user_data()
      # "asdfg"
  """

  def get_user_data do
    guess = IO.gets("Guess a five-letter word: ")
    cond do
      guess == "stop\n" ->
        Games.main(1)

      String.length(guess) < 6 || String.length(guess) > 6 ->
        IO.puts(
          "#{IO.ANSI.red()}\nEnter a string exactly of 5 letters! #{IO.ANSI.default_color()}\n"
        )

        get_user_data()

      String.length(guess) === 6 ->
        guess
    end
  end

  @doc """
      generates a charlist of 5 lowercase chars

  # ##Examples
  #    iex> generate_string()
  #     ~c"asdfg"
  """
  def generate_string do
    Enum.map(1..5, fn _ ->
        Enum.random(?a..?z)
    end)
    # ~c"aaabb"
  end

  @doc """
      gives a hint of answer and a guess.
      Runs the compare function that retuns a list of color :atoms
      acepts two charlist-only arguments

  ##Examples
      iex> Games.Worlde.feedback(~c"aaaaa", ~c"aaaaa")
      [:green, :green, :green, :green, :green]
      iex> Games.Worlde.feedback(~c"aaaaa", ~c"aaaab")
      [:green, :green, :green, :green, :grey]
      iex> Games.Worlde.feedback(~c"abdce", ~c"edcba")
      [:yellow, :yellow, :yellow, :yellow, :yellow]

  """
  @spec feedback(list(), list()) :: list()
  def feedback(answer, guess) do
    Enum.with_index(guess)
    |> Enum.map(fn {c, i} ->
      cond do
        Enum.at(answer, i) == c ->
          :green

        at_different_position?(c, answer) and !used_up?(i, c, guess, answer) ->
          :yellow

        true ->
          :grey
      end
    end)
  end

  def at_different_position?(c, answer) do
    c in answer
  end

  def used_up?(i, c, guess, answer) do
    guess_occurrences = guess |> Enum.slice(0..i) |> Enum.filter(fn char -> char == c end) |> Enum.count()

    answer_occurrences = answer |> Enum.filter(fn char -> char == c end) |> Enum.count()

    guess_occurrences > answer_occurrences
  end

  # defp find_idxs(guess, answer, return \\ [])

  # defp find_idxs([], _, return), do: return

  # # defp find_idxs([_ahd | atl], answer, return) when length(answer)==0, do: find_idxs(atl, answer, return)
  # # defp find_idxs(guess,[] = answer, return), do: find_idxs(guess, answer, return )
  # defp find_idxs(_guess, [], return), do: return

  # defp find_idxs([ghd | gtl], answer = [ahd | atl], return) do


  #   # if answer == [] do
  #   #   find_idxs(gtl, [ahd| atl], return)
  #   # end

  #   cond do
  #     elem(ahd, 0) == ghd ->
  #       IO.puts("MATCH!!!")
  #       IO.puts(elem(ahd, 1))
  #       # elem(ahd,1)
  #       find_idxs(gtl, atl, return ++ [elem(ahd, 1)])

  #     elem(ahd, 0) !== ghd ->
  #       find_idxs([ghd | gtl], atl, return)
  #   end

  #   return
  # end



  @doc """
      function that manage and runs the whole game
      gives winning and loosing statements
  """

  def play(lifes \\ @lifes, answer \\ generate_string()) do
    if lifes >= 1 do
      IO.puts("\n-----======#{IO.ANSI.red()} Wordle #{IO.ANSI.default_color()}======----- \n")

      lifes_symbols =
        Enum.map(1..lifes, fn _life ->
          "♥"
        end)
        |> Enum.join(" ")

      IO.puts("Lifes: " <> IO.ANSI.red() <> lifes_symbols <> IO.ANSI.default_color())

      guess = String.to_charlist(String.slice(get_user_data(), 0..4))

      colors = feedback(answer, guess)
      indexed_colors = Enum.with_index(colors)

      painted =
        Enum.map(indexed_colors, fn color ->
          case elem(color, 0) do
            :grey ->
              "#{IO.ANSI.light_black()} #{[Enum.at(guess, elem(color, 1))]} #{IO.ANSI.default_color()}"

            :green ->
              "#{IO.ANSI.green()} #{List.to_string([Enum.at(guess, elem(color, 1))])}#{IO.ANSI.default_color()}"

            :yellow ->
              "#{IO.ANSI.yellow()} #{[Enum.at(guess, elem(color, 1))]} #{IO.ANSI.default_color()}"
          end
        end)

      IO.puts(painted)

      if :yellow in colors || :grey in colors do
        remain_lifes = lifes - 1
        play(remain_lifes, answer)
      else
        IO.puts("#{IO.ANSI.green()} \nYou Won! #{IO.ANSI.default_color()}\n")
        Games.main(1)
      end
    else
      IO.puts("#{IO.ANSI.red()}\nGame Over! #{IO.ANSI.default_color()}\n")
      IO.puts("The Answer was:"<>"#{IO.ANSI.green()} #{to_string(answer)}")
      Games.main(1)
    end
  end
end
