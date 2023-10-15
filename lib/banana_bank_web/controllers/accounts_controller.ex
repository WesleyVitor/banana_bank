defmodule BananaBankWeb.AccountsController do
  use BananaBankWeb, :controller

  alias BananaBank.Accounts
  alias Accounts.Account

  action_fallback BananaBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, account: account)
    end
  end
  def transaction(conn, %{
    "from_account" => from_account,
    "to_account" => to_account,
    "value" => value
    }) do

    with {:ok, transaction} <- Accounts.transaction(from_account, to_account, value) do
      conn
      |> put_status(:ok)
      |> render(:transaction, transaction: transaction)
    end
  end
end
