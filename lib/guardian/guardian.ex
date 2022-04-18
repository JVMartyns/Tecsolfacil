defmodule Tecsolfacil.Guardian do
  @moduledoc """
  Module responsible for verifying that the user has the necessary credentials to access the ap
  """

  use Guardian, otp_app: :tecsolfacil

  alias Tecsolfacil.Accounts

  def subject_for_token(%{email: email}, _claims) do
    sub = to_string(email)
    {:ok, sub}
  end

  def subject_for_token(_, _), do: {:error, :invalid_resource}

  def resource_from_claims(%{"sub" => email}) do
    resource = Accounts.get_user!(email)
    {:ok, resource}
  end

  def resource_from_claims(_claims), do: {:error, :invalid_token}
end
