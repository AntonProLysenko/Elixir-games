ExUnit.start(auto_run: false)

defmodule GamesTest do
  use ExUnit.Case
  doctest Games

  test "greets the world" do
    assert Games.hello() == :world
  end

  test "gives color array" do
    assert Games.Worlde.feedback(~c"aaaaa", ~c"aaaaa") == [:green, :green, :green, :green, :green]
    assert Games.Worlde.feedback(~c"aaaaa", ~c"aaaab") == [:green, :green, :green, :green, :grey]
    assert Games.Worlde.feedback(~c"abdce", ~c"edcba") == [:yellow, :yellow, :yellow, :yellow, :yellow]
    assert Games.Worlde.feedback(~c"aaabb", ~c"xaaaa") == [:grey, :green, :green, :yellow, :grey]
  end
end
