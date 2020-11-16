defmodule StripeClient.CLI do
  @moduledoc """
    Handles the command line parsing and the dispatch to
    the various functions that end up giving convinient
    access to Stripe's API
  """
  def run(argv) do
    process_args(argv)
  end

  defp process_args(argv) do
    OptionParser.parse!(argv, switches: [help: :boolean], aliases: [h: :help])
    "Not implemented yet."
  end
end
