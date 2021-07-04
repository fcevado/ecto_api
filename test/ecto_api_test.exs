defmodule EctoApiTest do
  use ExUnit.Case
  doctest EctoApi

  test "greets the world" do
    assert EctoApi.hello() == :world
  end
end
