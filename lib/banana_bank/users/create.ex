defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo
  alias BananaBank.ViaCep.Client, as: ViaCepClient
  def call(%{"cep" => cep} = params) do
    with {:ok, _} <- client_impl().call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client_impl() do
    Application.get_env(:banana_bank, :via_cep_client, ViaCepClient)
  end
end
