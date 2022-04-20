defmodule Tecsolfacil.CepClient do
  @callback get_address(binary()) :: {:ok, map()} | {:error, atom()}

  def get_address(cep), do: impl().get_address(cep)
  defp impl(), do: Application.get_env(:tecsolfacil, :cep_client, Tecsolfacil.Viacep)
end
