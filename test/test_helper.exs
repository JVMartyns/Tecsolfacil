ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Tecsolfacil.Repo, :manual)

Mox.defmock(Tecsolfacil.MockCepClient, for: Tecsolfacil.CepClient)
Application.put_env(:tecsolfacil, :cep_client, Tecsolfacil.MockCepClient)
