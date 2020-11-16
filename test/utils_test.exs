defmodule UtilsTest do
  @base_url Application.get_env(:stripe_client, :base_url)

  use ExUnit.Case
  doctest StripeClient

  import StripeClient.Utils, only: [handle_status_code: 1, get: 3]

  test "Tests that 200 status code returns :ok atom" do
    assert handle_status_code(200) == :ok
  end

  test "Test that anything other then 200 returns :error atom" do
    assert handle_status_code(555) == :error
  end

  test "gets wrapper return correct format" do
    assert get(@base_url, [], []) == {:ok, %{}} or {:error, %{}}
  end
end
