defmodule ElixirJobs.Core.Fields.JobType do
  @moduledoc """
  Field definition module to save in the database the type of an account
  """

  use Ecto.Type

  @values [
    :unknown,
    :full_time,
    :part_time,
    :freelance
  ]

  def available_values, do: @values

  @doc false
  def type, do: :string

  @doc """
  Cast an job type from the value input to verify that it's a registered value.

  ## Examples

    iex> cast(:full_time)
    {:ok, :full_time}

    iex> cast("full_time")
    {:ok, :full_time}

    iex> cast(:wadus)
    :error

  """
  @spec cast(atom()) :: {:ok, atom()} | :error
  def cast(value) when value in @values, do: {:ok, value}
  def cast(value) when is_binary(value), do: load(value)
  def cast(_value), do: :error

  @doc """
  Load a job type value from the adapter to adapt it to the desired format in the app.

  ## Examples

    iex> load("full_time")
    {:ok, :full_time}

    iex> load("wadus")
    :error

  """
  @spec load(String.t()) :: {:ok, atom()} | :error
  def load(value) when is_binary(value) do
    @values
    |> Enum.find(fn k -> to_string(k) == value end)
    |> case do
      k when not is_nil(k) ->
        {:ok, k}

      _ ->
        :error
    end
  end

  def load(_), do: :error

  @doc """
  Translate the value in the app side to the database type.

  ## Examples

    iex> dump(:full_time)
    {:ok, "full_time"}

    iex> dump(:wadus)
    :error

  """
  @spec dump(atom()) :: {:ok, String.t()} | :error
  def dump(value) when value in @values, do: {:ok, to_string(value)}
  def dump(_), do: :error
end
