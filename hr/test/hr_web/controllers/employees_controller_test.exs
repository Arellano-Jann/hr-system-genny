defmodule HrWeb.EmployeesControllerTest do
  use HrWeb.ConnCase

  import Hr.HumanResourcesFixtures

  alias Hr.HumanResources.Employees

  @create_attrs %{
    dep: "some dep",
    empid: "some empid",
    first: "some first",
    hire: ~D[2023-04-20],
    last: "some last"
  }
  @update_attrs %{
    dep: "some updated dep",
    empid: "some updated empid",
    first: "some updated first",
    hire: ~D[2023-04-21],
    last: "some updated last"
  }
  @invalid_attrs %{dep: nil, empid: nil, first: nil, hire: nil, last: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all employee", %{conn: conn} do
      conn = get(conn, ~p"/api/employee")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create employees" do
    test "renders employees when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/employee", employees: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/employee/#{id}")

      assert %{
               "id" => ^id,
               "dep" => "some dep",
               "empid" => "some empid",
               "first" => "some first",
               "hire" => "2023-04-20",
               "last" => "some last"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/employee", employees: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update employees" do
    setup [:create_employees]

    test "renders employees when data is valid", %{conn: conn, employees: %Employees{id: id} = employees} do
      conn = put(conn, ~p"/api/employee/#{employees}", employees: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/employee/#{id}")

      assert %{
               "id" => ^id,
               "dep" => "some updated dep",
               "empid" => "some updated empid",
               "first" => "some updated first",
               "hire" => "2023-04-21",
               "last" => "some updated last"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, employees: employees} do
      conn = put(conn, ~p"/api/employee/#{employees}", employees: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete employees" do
    setup [:create_employees]

    test "deletes chosen employees", %{conn: conn, employees: employees} do
      conn = delete(conn, ~p"/api/employee/#{employees}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/employee/#{employees}")
      end
    end
  end

  defp create_employees(_) do
    employees = employees_fixture()
    %{employees: employees}
  end
end
