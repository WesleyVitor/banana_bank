defmodule BananaBank.Repo.Migrations.CreateIndexToUsers do
  use Ecto.Migration

  def change do
    create index(:users, [:email], unique: true)
  end
end
