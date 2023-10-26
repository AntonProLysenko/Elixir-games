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



    def compare(answer, guess) do

        same_chars_indexes =
            Enum.map(guess, fn g ->
                if g in answer do
                    index = elem(Enum.with_index(answer)|> Enum.find(fn {char, index} -> char == g end),1)
                end
            end)
            |>Enum.filter(& !is_nil(&1))

        chunked =
            for a <- answer, g <- guess do
                {a, g}
            end
            |>Enum.chunk_every(5)
            |>Enum.with_index()


        color_matching_list =
            Enum.map(chunked, fn char_comparison->
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





        # Enum.map(same_chars_indexes, fn index ->
            # if Enum.at(color_matching_list, index) == :gray do
            #    color_matching_list = List.update_at(color_matching_list, index, fn _ -> :yellow end)
            # else
            #    color_matching_list
            # end
        # end)

        # for i<- same_chars_indexes, Enum.at(color_matching_list, i) == :gray do
        #     color_matching_list = List.update_at(color_matching_list, i, fn _color-> :yelow end)
        # end

        new_value = :yelow

        values = color_matching_list #List.duplicate(0, 5) # [0, 0, 0, 0, 0] in nicer form :-)
        indexes = same_chars_indexes

        values
        |> Enum.with_index
        |> Enum.map(fn {value, index} ->
            if index in indexes and value != :green do
                new_value
            else
                value
            end
        end)

    end




    def play do
        guess = String.to_charlist(String.slice(get_user_data(), 0..4))

        # answer = generate_string()
        answer = ~c"asdfg"

        feedback(answer, guess)

    end
end
