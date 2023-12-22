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

  def get_user_data(pid) do
    guess = IO.gets("Guess a five-letter word: ")
    cond do
      guess == "stop\n"  ->
        Games.main(pid)
        throw(:break)

      #String length is 6 since added /n at the end
      String.length(guess) === 6 -> guess
      String.length(guess) < 6 || String.length(guess) > 6 ->
        IO.puts(
          "#{IO.ANSI.red()}\nEnter a string exactly of 5 letters! #{IO.ANSI.default_color()}\n"
        )
        get_user_data(pid)
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


  @doc """
      function that manage and runs the whole game
      gives winning and loosing statements
  """

  def play(lifes \\ @lifes, answer \\ generate_string(), pid) do
    if lifes >= 1 do
      IO.puts("\n-----======#{IO.ANSI.red()} Wordle #{IO.ANSI.default_color()}======----- \n")

      lifes_symbols =
        Enum.map(1..lifes, fn _life ->
          "♥"
        end)
        |> Enum.join(" ")

      IO.puts("Lifes: " <> IO.ANSI.red() <> lifes_symbols <> IO.ANSI.default_color())

      guess =
        if get_user_data(pid) !="stop" do
          String.to_charlist(String.slice(get_user_data(pid), 0..4))
        else
          IO.puts("ELSE!!!")
          IO.inspect(get_user_data(pid))
          throw(:break)
          # play(0, answer, pid)
        end

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
        play(remain_lifes, answer, pid)
      else
        IO.puts("#{IO.ANSI.green()} \nYou Won! #{IO.ANSI.default_color()}\n")
        Games.Score.add_points(pid, 25)
        Games.main(pid)
      end
    else
      IO.puts("#{IO.ANSI.red()}\nGame Over! #{IO.ANSI.default_color()}\n")
      IO.puts("The Answer was:"<>"#{IO.ANSI.green()} #{to_string(answer)}#{IO.ANSI.default_color()}")
      Games.main(pid)
    end
  end
end
