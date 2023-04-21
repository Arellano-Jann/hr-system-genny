defmodule HrWeb.EmployeesController do
  use HrWeb, :controller

  alias Hr.HumanResources
  alias Hr.HumanResources.Employees

  def index(conn, _params) do
    employee = HumanResources.list_employee()
    render(conn, :index, employee: employee)
  end

  def new(conn, _params) do
    changeset = HumanResources.change_employees(%Employees{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"employees" => employees_params}) do
    case HumanResources.create_employees(employees_params) do
      {:ok, employees} ->
        conn
        |> put_flash(:info, "Employees created successfully.")
        |> redirect(to: ~p"/employee/#{employees}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    employees = HumanResources.get_employees!(id)
    render(conn, :show, employees: employees)
  end

  def edit(conn, %{"id" => id}) do
    employees = HumanResources.get_employees!(id)
    changeset = HumanResources.change_employees(employees)
    render(conn, :edit, employees: employees, changeset: changeset)
  end

  def update(conn, %{"id" => id, "employees" => employees_params}) do
    employees = HumanResources.get_employees!(id)

    case HumanResources.update_employees(employees, employees_params) do
      {:ok, employees} ->
        conn
        |> put_flash(:info, "Employees updated successfully.")
        |> redirect(to: ~p"/employee/#{employees}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, employees: employees, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    employees = HumanResources.get_employees!(id)
    {:ok, _employees} = HumanResources.delete_employees(employees)

    conn
    |> put_flash(:info, "Employees deleted successfully.")
    |> redirect(to: ~p"/employee")
  end
end
