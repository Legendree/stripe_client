defmodule UtilsTest do
  use ExUnit.Case
  doctest StripeClient

  test "greets the world" do
    assert StripeClient.hello() == :world
  end
end
