defmodule PostgresTest do
  use ExUnit.Case
  doctest Postgres

  test "greets the world" do
    assert Postgres.hello() == :world
  end
end
