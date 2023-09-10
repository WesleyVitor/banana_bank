defmodule BananaBank.Factory do

  alias BananaBank.Repo
  alias BananaBank.Users.User
  # with Ecto
  use ExMachina.Ecto, repo: Repo


  def user_factory do
    %User{
      name: "John Doe",
      email: sequence(:email, &"john-#{&1}@example.com"),
      cep: sequence(:cep, &"1234567#{&1}"),
      password_hash: create_password_hash(sequence("12345"))
    }
  end

  defp create_password_hash(password) do
    %{password_hash: password_hash} = Argon2.add_hash(password)
    password_hash
  end
end
