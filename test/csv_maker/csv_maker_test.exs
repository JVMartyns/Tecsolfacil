defmodule Tecsolfacil.CsvMakerTest do
  use Tecsolfacil.DataCase

  test "make/0" do
    head = "bairro,cep,complemento,ddd,gia,ibge,localidade,logradouro,siafi,uf"

    Tecsolfacil.CsvMaker.make()

    assert file = File.read!("addresses.csv")
    assert head in String.split(file, "\n", trim: true)
  end
end
