defmodule Games.Worlde do
    @lifes 6
    def get_user_data do
        answer = IO.gets("Guess a five-letter word: ")

        if String.length(answer) < 6 || String.length(answer) > 6 do
            IO.puts("#{IO.ANSI.red()}\nEnter a string exactly of 5 letters! #{IO.ANSI.default_color()}\n")
            get_user_data()
        else
            answer
        end

    end


    def generate_string do
        Enum.map(1..5, fn _ ->
            Enum.random(?a..?z)
        end)
    end

    def feedback(answer,guess)  do
        IO.inspect(answer, label: "answe")
        IO.inspect(guess, label: "guess")

        compare(answer, guess)
    end


    # def find_same_char_indexes([],answer), do: nil

    # def find_same_char_indexes([ ghd | gtl ], answer)do
    #     answer = [head|tail]

    #     return = []
    #     # counter = 0
    #     index_answer =

    #     if elem(ghd,0) in answer && !(elem(ghd,1) in return)  do
    #         # counter=counter+1
    #         return = [elem(ghd,1)|return]
    #         find_same_char_indexes(gtl, answer)
    #     else
    #         find_same_char_indexes(gtl, answer)
    #     end

    #     return

    # end




    def compare(answer, guess) do
        indexed_answer = Enum.with_index(answer)

        same_chars_indexes =
            Enum.map(guess, fn g ->
                if g in answer  do
                    Enum.find(indexed_answer, fn {char, _index} ->
                         char == g end)
                    |>elem(0)
                end
            end)
            |>Enum.with_index()
            |> Enum.map(fn el ->
                if elem(el,0) !== nil do
                    elem(el,1)
                end
            end)
            |>Enum.filter(& !is_nil(&1))
            IO.inspect(same_chars_indexes, label: "Indexes")


        chunked =
            for a <- answer,  g <- guess do
                {a, g}
            end
            |>Enum.chunk_every(5)
            # |>IO.inspect(label: "Whole")


        color_matching_list =
            Enum.map(chunked|>Enum.with_index(), fn char_comparison->
                index = elem(char_comparison, 1)
                comparison = elem(char_comparison, 0)
                Enum.at(comparison,index)
            end)
            |>
            Enum.map(fn two_chars->
                if elem(two_chars, 0) === elem(two_chars, 1) do
                    :green
                else
                    :gray
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
            if index in same_chars_indexes and color != :green and color != :yelow do
                :yelow
            else
                color
            end
        end)



    end



    def play do
        guess = String.to_charlist(String.slice(get_user_data(), 0..4))
        # answer = generate_string()
        answer = ~c"aaabb"
        # answer = ~c"asdfg"

        feedback(answer, guess)

    end
end
