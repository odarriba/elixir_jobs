defmodule ElixirJobs.Offers.Fields.JobPlace do
  @moduledoc """
  Field definition module to save in the database the type of an account
  """

  @behaviour Ecto.Type

  @values [
    :unknown,
    :onsite,
    :remote,
    :both
  ]

  def available_values, do: @values

  @doc false
  def type, do: :string

  @doc """
  Cast an job place from the value input to verify that it's a registered value.

  ## Examples

    iex> cast(:onsite)
    {:ok, :onsite}

    iex> cast("onsite")
    {:ok, :onsite}

    iex> cast(:wadus)
    :error

  """
  @spec cast(atom()) :: {:ok, atom()} | :error
  def cast(value) when value in @values, do: {:ok, value}
  def cast(value) when is_binary(value), do: load(value)
  def cast(_value), do: :error

  @doc """
  Load a job place value from the adapter to adapt it to the desired format in the app.

  ## Examples

    iex> load("onsite")
    {:ok, :onsite}

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

    iex> dump(:onsite)
    {:ok, "onsite"}

    iex> dump(:wadus)
    :error

  """
  @spec dump(atom()) :: {:ok, String.t()} | :error
  def dump(value) when value in @values, do: {:ok, to_string(value)}
  def dump(_), do: :error
end
