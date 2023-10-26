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

        chunked =
            for a <- answer, g <- guess do
                {a, g}
            end
            |>Enum.chunk_every(5)
            |>Enum.with_index()

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

    end


    def play do
        guess = String.to_charlist(String.slice(get_user_data(), 0..4))

        # answer = generate_string()
        answer = ~c"asdfg"

        feedback(answer, guess)

    end
end
