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
        guess = IO.gets("Guess a five-letter word: ")|>IO.inspect(label: "Guess")

        cond do
            guess == "stop\n" -> Games.main(1)
            String.length(guess) < 6 || String.length(guess) > 6 -> IO.puts("#{IO.ANSI.red()}\nEnter a string exactly of 5 letters! #{IO.ANSI.default_color()}\n"); get_user_data()
            String.length(guess) === 6 -> guess
        end

    end

    @doc """
        generates a charlist of 5 lowercase chars

    # ##Examples
    #    iex> generate_string()
    #     ~c"asdfg"
    """
    def generate_string do
        # Enum.map(1..5, fn _ ->
        #     Enum.random(?a..?z)
        # end)
         ~c"aaabb"
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
    def feedback(answer,guess)  do
        IO.inspect(answer, label: "answe")
        IO.inspect(guess, label: "guess")

        compare(answer, guess)
    end

    defp find_idxs(guess, answer , return\\[])

    defp find_idxs([], _ , return), do: return
    # defp find_idxs([_ahd | atl], answer, return) when length(answer)==0, do: find_idxs(atl, answer, return)
    # defp find_idxs(guess,[] = answer, return), do: find_idxs(guess, answer, return )
    defp find_idxs(_guess,[], return), do: return


    defp find_idxs([ghd | gtl], answer = [ahd| atl], return) do

            IO.inspect([ahd| atl], label: "indexed answ")
            IO.inspect(ahd, label: "compared AHD")
            IO.inspect(ghd, label: "compared G")
            IO.inspect(return, label: "RETURN")
            IO.inspect(length(answer), label: "length ANSW")

            # if answer == [] do
            #   find_idxs(gtl, [ahd| atl], return)
            # end

            cond do
                elem(ahd, 0) == ghd ->
                    IO.puts("MATCH!!!")
                    IO.puts(elem(ahd, 1))
                    # elem(ahd,1)
                    find_idxs(gtl, atl, return ++ [elem(ahd,1)])

                elem(ahd, 0) !== ghd ->
                    find_idxs([ghd | gtl], atl, return)
            end
        return
    end



    @doc """
        main function of the game
        compares two charlists and return a list of color-atoms

        color_matching_list is a return
            colors in color_matching_list depends:
                if the char in guess in a right place -> it replaces the char with a :green atom
                if a char in guess not found in the answer -> it replaces with a :grey atom
                if a char in guess exists in answer but placed in a wrong place -> it replaces with a :yellow atom
        same_chars_indexes - is a var where we are saving all the matching chars's indexes
        color_matching_list - is a var where :green and :grey atoms are assigned
        and then  color_matching_list is getting merged with  same_chars_indexes excluding :green values
    """
    @spec compare(list(), list()) :: list()
    def compare(answer, guess) do

        same_chars_indexes =
            Enum.map(guess, fn g ->
                if g in answer  do

                    if find_idxs(guess, Enum.with_index(answer)) == []do
                        find_idxs((guess--[hd guess]), Enum.with_index(answer))
                    end

                else
                  nil
                end
            end)
            # |>Enum.with_index()
            # |> Stream.map(fn {num, idx} ->
            #     if num !== nil do
            #         idx
            #     end
            # end)
            # |>Enum.filter(& !is_nil(&1))
            IO.inspect(same_chars_indexes, label: "IDXS")

        chunked =
            for a <- answer,  g <- guess do
                {a, g}
            end
            |>Enum.chunk_every(5)



        color_matching_list =
            Enum.map(Enum.with_index(chunked), fn char_comparison->
                index = elem(char_comparison, 1)
                comparison = elem(char_comparison, 0)
                Enum.at(comparison,index)
            end)
            |>
            Enum.map(fn two_chars->
                if elem(two_chars, 0) === elem(two_chars, 1) do
                    :green
                else
                    :grey
                end
            end)

        # test_index_array =
        #     Enum.map(chunked, fn row->
        #         Enum.with_index(row)
        #         |>
        #         Enum.map(fn{char_pair,index} ->
        #             if elem(char_pair,0) == elem(char_pair,1) do
        #                 index
        #             end
        #         end)
        #     end)
        #     |>Enum.with_index()
        #     |>IO.inspect()
        #     |> Enum.map(fn {row,index}->
        #         Enum.at(row,index+1)
        #     end)
        #     |>Enum.filter(& !is_nil(&1))
        #     IO.inspect(test_index_array, label: "Test Indexes")


         Enum.with_index(color_matching_list)
        |> Enum.map(fn {color, index} ->
            if index in same_chars_indexes and color === :grey do
                :yellow
            else
                color
            end
        end)
    end



    @doc """
        function that manage and runs the whole game
        gives winning and loosing statements
    """

    def play(lifes\\ @lifes, answer\\generate_string()) do

        if lifes >=1 do
            IO.puts("\n-----======#{IO.ANSI.red()} Wordle #{IO.ANSI.default_color()}======----- \n")

            lifes_symbols =
                Enum.map(1..lifes, fn _life ->
                    "♥"
                end)
                |>Enum.join(" ")
            IO.puts("Lifes: "<>IO.ANSI.red()<>lifes_symbols<>IO.ANSI.default_color())

            guess = String.to_charlist(String.slice(get_user_data(), 0..4))

            colors = feedback(answer, guess)
            indexed_colors = Enum.with_index(colors)



            painted = Enum.map(indexed_colors, fn color->
                case elem(color,0) do
                :grey -> "#{IO.ANSI.light_black()} #{[Enum.at(guess, elem(color,1))]} #{ IO.ANSI.default_color()}"
                :green -> "#{IO.ANSI.green()} #{List.to_string([Enum.at(guess, elem(color,1))])}#{ IO.ANSI.default_color()}"
                :yellow -> "#{IO.ANSI.yellow()} #{[Enum.at(guess, elem(color,1))]} #{IO.ANSI.default_color()}"
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
          Games.main(1)
        end
    end
end
