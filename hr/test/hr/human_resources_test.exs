defmodule Hr.HumanResourcesTest do
  use Hr.DataCase

  alias Hr.HumanResources

  describe "employee" do
    alias Hr.HumanResources.Employees

    import Hr.HumanResourcesFixtures

    @invalid_attrs %{dep: nil, empid: nil, first: nil, hire: nil, last: nil}

    test "list_employee/0 returns all employee" do
      employees = employees_fixture()
      assert HumanResources.list_employee() == [employees]
    end

    test "get_employees!/1 returns the employees with given id" do
      employees = employees_fixture()
      assert HumanResources.get_employees!(employees.id) == employees
    end

    test "create_employees/1 with valid data creates a employees" do
      valid_attrs = %{dep: "some dep", empid: "some empid", first: "some first", hire: ~D[2023-04-20], last: "some last"}

      assert {:ok, %Employees{} = employees} = HumanResources.create_employees(valid_attrs)
      assert employees.dep == "some dep"
      assert employees.empid == "some empid"
      assert employees.first == "some first"
      assert employees.hire == ~D[2023-04-20]
      assert employees.last == "some last"
    end

    test "create_employees/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HumanResources.create_employees(@invalid_attrs)
    end

    test "update_employees/2 with valid data updates the employees" do
      employees = employees_fixture()
      update_attrs = %{dep: "some updated dep", empid: "some updated empid", first: "some updated first", hire: ~D[2023-04-21], last: "some updated last"}

      assert {:ok, %Employees{} = employees} = HumanResources.update_employees(employees, update_attrs)
      assert employees.dep == "some updated dep"
      assert employees.empid == "some updated empid"
      assert employees.first == "some updated first"
      assert employees.hire == ~D[2023-04-21]
      assert employees.last == "some updated last"
    end

    test "update_employees/2 with invalid data returns error changeset" do
      employees = employees_fixture()
      assert {:error, %Ecto.Changeset{}} = HumanResources.update_employees(employees, @invalid_attrs)
      assert employees == HumanResources.get_employees!(employees.id)
    end

    test "delete_employees/1 deletes the employees" do
      employees = employees_fixture()
      assert {:ok, %Employees{}} = HumanResources.delete_employees(employees)
      assert_raise Ecto.NoResultsError, fn -> HumanResources.get_employees!(employees.id) end
    end

    test "change_employees/1 returns a employees changeset" do
      employees = employees_fixture()
      assert %Ecto.Changeset{} = HumanResources.change_employees(employees)
    end
  end
end
