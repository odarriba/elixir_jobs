defmodule ElixirJobs.Factories.Base do
  @moduledoc """
  Base module for project's factories.

  Includes macros used for building structs and persist them during tests
  """
  defmacro __using__(factory) do
    quote do
      @behaviour ElixirJobs.Factories.Base.Behaviour
      @factory unquote(factory)
      @base_module unquote(__CALLER__.module)

      defmacro __using__(_) do
        quote do
          def build_factory(unquote(@factory)),
            do: unquote(@base_module).build_factory()

          def get_schema(unquote(@factory)),
            do: unquote(@base_module).get_schema()

          def get_changeset(attrs, unquote(@factory)),
            do: unquote(@base_module).get_changeset(attrs)
        end
      end
    end
  end

  defmodule Behaviour do
    @moduledoc false

    @callback build_factory() :: map()
    @callback get_schema() :: map()
    @callback get_changeset(map()) :: Ecto.Changeset.t()
  end
end
