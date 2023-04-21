defmodule HrWeb.EmployeesHTML do
  use HrWeb, :html

  embed_templates "employees_html/*"

  @doc """
  Renders a employees form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def employees_form(assigns)
end
