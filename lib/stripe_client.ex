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

  def balance(private_key) do
    StripeClient.Utils.get("#{@base_url}/v1/balance", [
      {"Authorization", "Bearer #{private_key}"}
    ])
  end

  def balance_transactions(private_key, opts \\ []) do
    limit = Keyword.get(opts, :limit)

    _balance_transactions(private_key, limit)
  end

  defp _balance_transactions(private_key, limit) when is_integer(limit) do
    StripeClient.Utils.get("#{@base_url}/v1/balance_transactions?limit=#{limit}", [
      {"Authorization", "Bearer #{private_key}"}
    ])
  end

  defp _balance_transactions(private_key, nil) do
    StripeClient.Utils.get(
      "#{@base_url}/v1/balance_transactions",
      [{"Authorization", "Bearer #{private_key}"}]
    )
  end

  def balance_transaction(private_key, transaction_id) when is_bitstring(transaction_id) do
    StripeClient.Utils.get("#{@base_url}/v1/balance_transactions/#{transaction_id}", [
      {"Authorization", "Bearer #{private_key}"}
    ])
  end

  @doc """
    Creates charge with specified amount, currency, and description
    You can view supported currencies at https://stripe.com/docs/currencies
  """
  def create_charge(
        private_key,
        amount,
        description,
        currency \\ "usd",
        source \\ "tok_mastercard"
      ) do
    body =
      URI.encode_query(%{
        "amount" => amount,
        "description" => description,
        "currency" => currency,
        "source" => source
      })

    StripeClient.Utils.post(
      "#{@base_url}/v1/charges",
      body,
      [
        {"Authorization", "Bearer #{private_key}"},
        {"Content-Type", "application/x-www-form-urlencoded"}
      ]
    )
  end
end
