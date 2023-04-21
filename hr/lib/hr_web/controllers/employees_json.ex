defmodule HrWeb.EmployeesJSON do
  alias Hr.HumanResources.Employees

  @doc """
  Renders a list of employee.
  """
  def index(%{employee: employee}) do
    %{data: for(employees <- employee, do: data(employees))}
  end

  @doc """
  Renders a single employees.
  """
  def show(%{employees: employees}) do
    %{data: data(employees)}
  end

  defp data(%Employees{} = employees) do
    %{
      id: employees.id,
      empid: employees.empid,
      last: employees.last,
      first: employees.first,
      hire: employees.hire,
      dep: employees.dep
    }
  end
end
