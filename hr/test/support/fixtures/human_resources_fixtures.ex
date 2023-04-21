defmodule Hr.HumanResourcesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hr.HumanResources` context.
  """

  @doc """
  Generate a employees.
  """
  def employees_fixture(attrs \\ %{}) do
    {:ok, employees} =
      attrs
      |> Enum.into(%{
        dep: "some dep",
        first: "some first",
        hire: ~D[2023-04-20],
        id: "some id",
        last: "some last"
      })
      |> Hr.HumanResources.create_employees()

    employees
  end
end
