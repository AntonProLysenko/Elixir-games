defmodule Games.Worlde do
    @lifes 6
    def get_user_data do
        answer = IO.gets("gues a word of 5 letters: ")

        IO.puts(String.length(answer))

        if String.length(answer) < 6 || String.length(answer) > 6 do
            IO.puts("Enter a string exactly of 5 letters! \n")
            get_user_data()
        else
            answer
        end

    end
    def generate_string do
      Enum.map(1..5, fn _ -> Enum.random(?a..?z) end)
    end
    # def feedback answer, guess  do

    # end


    def play do
        guess = get_user_data()
        answer = generate_string()
    end
end
