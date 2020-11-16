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

  @doc """
    Your API keys carry many privileges, so be sure to keep them secure!
    Do not share your secret API keys in publicly accessible areas
    such as GitHub, client-side code, and so forth.
    Authentication to the API is performed via HTTP Basic Auth.
    Provide your API key as the basic auth username value.
    You do not need to provide a password.
  """
  @spec authenticate(String.t()) :: tuple()
  def authenticate(private_key) do
    StripeClient.Utils.get("#{@base_url}/v1/charges", [
      {"Authorization", "Bearer #{private_key}"}
    ])
  end

  @spec balance(String.t()) :: tuple()
  def balance(private_key) do
    StripeClient.Utils.get("#{@base_url}/v1/balance", [
      {"Authorization", "Bearer #{private_key}"}
    ])
  end

  @spec balance_transactions(String.t(), list()) :: tuple()
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

  @spec balance_transaction(String.t(), String.t()) :: tuple()
  def balance_transaction(private_key, transaction_id) when is_bitstring(transaction_id) do
    StripeClient.Utils.get("#{@base_url}/v1/balance_transactions/#{transaction_id}", [
      {"Authorization", "Bearer #{private_key}"}
    ])
  end

  @doc """
    Creates charge with specified amount, currency, and description
    You can view supported currencies at https://stripe.com/docs/currencies
  """
  @spec create_charge(String.t(), integer(), String.t(), String.t(), String.t()) :: tuple()
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

  @spec retrive_charge(String.t(), String.t()) :: tuple()
  def retrive_charge(private_key, charge_id) do
    StripeClient.Utils.get("#{@base_url}/v1/charges/#{charge_id}", [
      {"Authorization", "Bearer #{private_key}"}
    ])
  end

  @doc """
    Updates desierd fields in any of provided charges id
    parameters_to_update = %{"metadata[order_id]" => 6735}
  """
  @spec update_charge(String.t(), String.t(), map()) :: tuple()
  def update_charge(private_key, charge_id, parameters_to_update \\ %{}) do
    body = URI.encode_query(parameters_to_update)

    StripeClient.Utils.post("#{@base_url}/v1/charges/#{charge_id}", body, [
      {"Authorization", "Bearer #{private_key}"},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ])
  end
end
