defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account

  def create(%{account: account}) do
    %{
      message: "Conta criada com sucesso!",
      data: data(account)
    }
  end
  def transaction(%{transaction: %{withdraw: withdraw, deposit: deposit}}) do
    %{
      message: "Transação concluida com sucesso!",
      from: withdraw.id,
      to: deposit.id,
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      balance: account.balance,
      user_id: account.user_id
    }
  end
end
