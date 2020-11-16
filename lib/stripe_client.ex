defmodule StripeClient do
  @base_url Application.get_env(:stripe_client, :base_url)
  @moduledoc """
  Stripe API wrapper for convinient integgration in your elixir apps
  You can checkout Stripe documentation at https://stripe.com/docs
  """

  @doc """
  Hello world.

  ## Examples

      iex> StripeClient.hello()
      :world

  """
  def hello do
    :world
  end

  def authenticate(private_key) do
    StripeClient.Utils.get("#{@base_url}/v1/charges", [
      {"Authorization", "Bearer #{private_key}"}
    ])
  end
end
