ExUnit.start(auto_run: false)

defmodule GamesTest do
  use ExUnit.Case
  doctest Games.Worlde



  test "gives color array" do
    assert Games.Worlde.feedback(~c"aaaaa", ~c"aaaaa") == [:green, :green, :green, :green, :green]
    assert Games.Worlde.feedback(~c"aaaaa", ~c"aaaab") == [:green, :green, :green, :green, :grey]
    assert Games.Worlde.feedback(~c"abdce", ~c"edcba") == [:yellow, :yellow, :yellow, :yellow, :yellow]
    assert Games.Worlde.feedback(~c"aaabb", ~c"xaaaa") == [:grey, :green, :green, :yellow, :grey]
  end

  test "used_up?" do
    assert Games.Worlde.used_up?(4, ?a, ~c"xaaaa", ~c"aaabb")
    refute Games.Worlde.used_up?(0, ?a, ~c"abdce", ~c"edcba")
    refute Games.Worlde.used_up?(3, ?a, ~c"xaaaa", ~c"aaabb")
  end
  # test "gives list of indexes of all matching chars" do
  #   # assert Games.Worlde.find_idxs(, ~c""")
  # end
end

defmodule ScoreTest do
  use ExUnit.Case
  doctest Games.Score

    test "score tracking" do
    {:ok, pid} = Games.Score.start_link()
    assert Games.Score.get_score(pid) == 0
    Games.Score.add_points(pid, 10)
    Games.Score.add_points(pid ,10)
    assert Games.Score.get_score(pid) == 20


  end
end
