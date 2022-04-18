defmodule Tecsolfacil.CsvMaker do
  @moduledoc """
  Module responsible for creating a CSV file with the addresses stored in the database
  """
  alias Tecsolfacil.Addresses.Address
  alias Tecsolfacil.Repo

  def make do
    get_list_of_addresses()
    |> convert_to_csv()
  end

  defp get_list_of_addresses do
    header = [
      [
        "bairro",
        "cep",
        "complemento",
        "ddd",
        "gia",
        "ibge",
        "localidade",
        "logradouro",
        "siafi",
        "uf"
      ]
    ]

    addresses =
      Address
      |> Repo.all()
      |> Enum.map(fn x ->
        [
          x.bairro,
          x.cep,
          x.complemento,
          x.ddd,
          x.gia,
          x.ibge,
          x.localidade,
          x.logradouro,
          x.siafi,
          x.uf
        ]
      end)

    header ++ addresses
  end

  defp convert_to_csv(data) do
    col_sep = ","
    row_sep = "\n"

    csv =
      for row <- data, into: "" do
        Enum.join(row, col_sep) <> row_sep
      end

    File.write("addresses.csv", csv)
  end
end
