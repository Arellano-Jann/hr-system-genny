defmodule Hr.Repo.Migrations.CreateEmployee do
  use Ecto.Migration

  def change do
    create table(:employee) do
      add :id, :string
      add :last, :string
      add :first, :string
      add :hire, :date
      add :dep, :string

      timestamps()
    end
  end
end
