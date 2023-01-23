defmodule TypetestTest do
  use ExUnit.Case
  doctest Typetest

  test "greets the world" do
    assert Typetest.hello() == :world
  end
end
