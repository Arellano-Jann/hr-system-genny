defmodule HrWeb.EmployeesControllerTest do
  use HrWeb.ConnCase

  import Hr.HumanResourcesFixtures

  @create_attrs %{dep: "some dep", first: "some first", hire: ~D[2023-04-20], id: "some id", last: "some last"}
  @update_attrs %{dep: "some updated dep", first: "some updated first", hire: ~D[2023-04-21], id: "some updated id", last: "some updated last"}
  @invalid_attrs %{dep: nil, first: nil, hire: nil, id: nil, last: nil}

  describe "index" do
    test "lists all employee", %{conn: conn} do
      conn = get(conn, ~p"/employee")
      assert html_response(conn, 200) =~ "Listing Employee"
    end
  end

  describe "new employees" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/employee/new")
      assert html_response(conn, 200) =~ "New Employees"
    end
  end

  describe "create employees" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/employee", employees: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/employee/#{id}"

      conn = get(conn, ~p"/employee/#{id}")
      assert html_response(conn, 200) =~ "Employees #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/employee", employees: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Employees"
    end
  end

  describe "edit employees" do
    setup [:create_employees]

    test "renders form for editing chosen employees", %{conn: conn, employees: employees} do
      conn = get(conn, ~p"/employee/#{employees}/edit")
      assert html_response(conn, 200) =~ "Edit Employees"
    end
  end

  describe "update employees" do
    setup [:create_employees]

    test "redirects when data is valid", %{conn: conn, employees: employees} do
      conn = put(conn, ~p"/employee/#{employees}", employees: @update_attrs)
      assert redirected_to(conn) == ~p"/employee/#{employees}"

      conn = get(conn, ~p"/employee/#{employees}")
      assert html_response(conn, 200) =~ "some updated dep"
    end

    test "renders errors when data is invalid", %{conn: conn, employees: employees} do
      conn = put(conn, ~p"/employee/#{employees}", employees: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Employees"
    end
  end

  describe "delete employees" do
    setup [:create_employees]

    test "deletes chosen employees", %{conn: conn, employees: employees} do
      conn = delete(conn, ~p"/employee/#{employees}")
      assert redirected_to(conn) == ~p"/employee"

      assert_error_sent 404, fn ->
        get(conn, ~p"/employee/#{employees}")
      end
    end
  end

  defp create_employees(_) do
    employees = employees_fixture()
    %{employees: employees}
  end
end
