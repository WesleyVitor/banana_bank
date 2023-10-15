defmodule BananaBank.Users.Verify do

  alias BananaBank.Users

  def call(%{"id" => id, "password" => password} = params) do
    case Users.get(id) do
      {:ok, user} -> verify(user, password)
      {:error, _} = error -> error
    end
  end

  defp verify(user, password) do
    Argon2.verify_pass(password, user.password_hash)
    |> valid_password?()
  end

  defp valid_password?(true), do: {:ok, :valid_password}
  defp valid_password?(false), do: {:error, :invalid_password}
end
