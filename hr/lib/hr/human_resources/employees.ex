defmodule Hr.HumanResources.Employees do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employee" do
    field :dep, :string
    field :first, :string
    field :hire, :date
    field :id, :string
    field :last, :string

    timestamps()
  end

  @doc false
  def changeset(employees, attrs) do
    employees
    |> cast(attrs, [:id, :last, :first, :hire, :dep])
    |> validate_required([:id, :last, :first, :hire, :dep])
  end
end
