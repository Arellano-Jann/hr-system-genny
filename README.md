# hr-system-genny

# commands

```
mix phx.new hr
cd hr
mix ecto.create
mix setup

mix phx.gen.html HumanResources Employees employee empid:string last:string first:string hire:date dep:string

mix ecto.migrate

mix phx.gen.json HumanResources Employees employee empid:string last:string first:string hire:date dep:string

mix ecto.migrate
```