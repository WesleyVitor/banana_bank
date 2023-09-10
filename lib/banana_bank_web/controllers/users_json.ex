defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "Usuário criado com sucesso!",
      data: data(user)
    }
  end

  def get(%{user: user}) do
    %{
      message: "Usuário encontrado com sucesso!",
      data: data(user)
    }
  end
  def update(%{user: user}) do
    %{
      message: "Usuário atualizado com sucesso!",
      data: data(user)
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      cep: user.cep
    }
  end
end
