defmodule DataSourceTest do
  use ExUnit.Case
  doctest DataSource

  test "greets the world" do
    assert DataSource.hello() == :world
  end
end
