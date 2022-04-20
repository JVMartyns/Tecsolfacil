defmodule Tecsolfacil.CepClient do
  @moduledoc """
  In production environment this module redirects to the Viacep module that will make a real api request. In Test environment this module redirects to the MockCepClient module that will pass predefined attributes in test.
  """
  @callback get_address(binary) :: {:ok, map} | {:error, atom}

  def get_address(cep), do: impl().get_address(cep)
  defp impl, do: Application.get_env(:tecsolfacil, :cep_client, Tecsolfacil.Viacep)
end
