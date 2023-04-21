defmodule Hr.HumanResources do
  @moduledoc """
  The HumanResources context.
  """

  import Ecto.Query, warn: false
  alias Hr.Repo

  alias Hr.HumanResources.Employees

  @doc """
  Returns the list of employee.

  ## Examples

      iex> list_employee()
      [%Employees{}, ...]

  """
  def list_employee do
    Repo.all(Employees)
  end

  @doc """
  Gets a single employees.

  Raises `Ecto.NoResultsError` if the Employees does not exist.

  ## Examples

      iex> get_employees!(123)
      %Employees{}

      iex> get_employees!(456)
      ** (Ecto.NoResultsError)

  """
  def get_employees!(id), do: Repo.get!(Employees, id)

  @doc """
  Creates a employees.

  ## Examples

      iex> create_employees(%{field: value})
      {:ok, %Employees{}}

      iex> create_employees(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_employees(attrs \\ %{}) do
    %Employees{}
    |> Employees.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a employees.

  ## Examples

      iex> update_employees(employees, %{field: new_value})
      {:ok, %Employees{}}

      iex> update_employees(employees, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_employees(%Employees{} = employees, attrs) do
    employees
    |> Employees.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a employees.

  ## Examples

      iex> delete_employees(employees)
      {:ok, %Employees{}}

      iex> delete_employees(employees)
      {:error, %Ecto.Changeset{}}

  """
  def delete_employees(%Employees{} = employees) do
    Repo.delete(employees)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking employees changes.

  ## Examples

      iex> change_employees(employees)
      %Ecto.Changeset{data: %Employees{}}

  """
  def change_employees(%Employees{} = employees, attrs \\ %{}) do
    Employees.changeset(employees, attrs)
  end
end
