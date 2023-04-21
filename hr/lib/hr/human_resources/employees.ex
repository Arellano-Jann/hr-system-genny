defmodule Hr.HumanResources.Employees do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employee" do
    field :dep, :string
    field :empid, :string
    field :first, :string
    field :hire, :date
    field :last, :string

    timestamps()
  end

  @doc false
  def changeset(employees, attrs) do
    employees
    |> cast(attrs, [:empid, :last, :first, :hire, :dep])
    |> validate_required([:empid, :last, :first, :hire, :dep])
  end
end
