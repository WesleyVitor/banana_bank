defmodule BananaBank.Accounts.Transaction do
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo
  alias Ecto.Multi

  def call(from_account_id, to_account_id, value) do
    with %Account{} = from_account <- Repo.get(Account, from_account_id),
        %Account{} = to_account <- Repo.get(Account, to_account_id) do

      Multi.new()
      |> changes(from_account, to_account, value)
      |> Repo.transaction()

    else
      nil -> {:error, :not_found}
    end
  end

  defp changes(multi, from_account, to_account, value) do
    multi
    |> withdraw(from_account, value)
    |> deposit(to_account, value)
  end

  defp withdraw(multi, from_account, value) do
    new_balance = Decimal.sub(from_account.balance, value)
    changeset = Account.changeset(from_account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp deposit(multi, to_account, value) do
    new_balance = Decimal.add(to_account.balance, value)
    changeset = Account.changeset(to_account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end
end
