defmodule BananaBank.Accounts.Create do
  alias BananaBank.Accounts.Account
  alias BananaBank.Users
  alias BananaBank.Repo


  def call(%{"user_id"=>user_id} = params) do
    with {:ok, _} <- Users.get(user_id) do
      params
        |> Account.changeset()
        |> Repo.insert()
    end
  end

end
