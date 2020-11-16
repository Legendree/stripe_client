defmodule StripeClient.Utils do
  @doc """
    Wrapper for handling the HTTPoison response
  """
  def get(url, headers \\ [], options \\ []) do
    HTTPoison.get(url, headers, options) |> handle_response()
  end

  def handle_response({:ok, %{status_code: status_code, body: body}}) do
    {status_code |> handle_status_code(), body |> Poison.Parser.parse!(%{})}
  end

  def handle_response(_, %{status_code: status_code}) do
    {:error, status_code}
  end

  def handle_status_code(200) do
    :ok
  end

  def handle_status_code(_) do
    :error
  end
end
