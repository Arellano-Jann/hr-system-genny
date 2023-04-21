defmodule HrWeb.EmployeesController do
  use HrWeb, :controller

  alias Hr.HumanResources
  alias Hr.HumanResources.Employees

  action_fallback HrWeb.FallbackController

  def index(conn, _params) do
    employee = HumanResources.list_employee()
    render(conn, :index, employee: employee)
  end

  def create(conn, %{"employees" => employees_params}) do
    with {:ok, %Employees{} = employees} <- HumanResources.create_employees(employees_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/employee/#{employees}")
      |> render(:show, employees: employees)
    end
  end

  def show(conn, %{"id" => id}) do
    employees = HumanResources.get_employees!(id)
    render(conn, :show, employees: employees)
  end

  def update(conn, %{"id" => id, "employees" => employees_params}) do
    employees = HumanResources.get_employees!(id)

    with {:ok, %Employees{} = employees} <- HumanResources.update_employees(employees, employees_params) do
      render(conn, :show, employees: employees)
    end
  end

  def delete(conn, %{"id" => id}) do
    employees = HumanResources.get_employees!(id)

    with {:ok, %Employees{}} <- HumanResources.delete_employees(employees) do
      send_resp(conn, :no_content, "")
    end
  end
end
