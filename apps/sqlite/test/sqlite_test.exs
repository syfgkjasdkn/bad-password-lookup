defmodule SQLiteTest do
  use ExUnit.Case
  doctest SQLite

  test "greets the world" do
    assert SQLite.hello() == :world
  end
end
