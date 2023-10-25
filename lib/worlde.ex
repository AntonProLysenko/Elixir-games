defmodule Games.Worlde do
    @lifes 6
    def get_user_data do
        answer = IO.gets("gues a word of 5 letters: ")

        if String.length(answer) < 6 || String.length(answer) > 6 do
            IO.puts("Enter a string exactly of 5 letters! \n")
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
        IO.inspect(answer, label: "answ")
        IO.inspect(guess, label: "guess")

        compare(answer, guess)
    end



    def compare(answer, guess) do

        for a <- answer, g <- guess do
            cond do
              a == g -> IO.puts(:yelow)
              true -> IO.puts("none")
            end
            {a, g}
        end


    end


    def play do
        guess = String.to_charlist(String.slice(get_user_data(), 0..4))

        answer = generate_string()

        feedback(answer, guess)

    end
end
