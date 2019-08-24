defmodule ElixirJobsWeb.Date do
  @moduledoc """
  Module with date-related calculation and helper functions.
  """

  def diff(date1, date2) do
    date1 = date1 |> castin()
    date2 = date2 |> castin()

    case Calendar.DateTime.diff(date1, date2) do
      {:ok, seconds, _, :before} -> -1 * seconds
      {:ok, seconds, _, _} -> seconds
      _ -> nil
    end
  end

  def strftime(date, format) do
    {:ok, string} =
      date
      |> castin()
      |> Calendar.Strftime.strftime(format)

    string
  end

  # Casts Ecto.DateTimes coming into this module
  defp castin(%DateTime{} = date) do
    date
    |> DateTime.to_naive()
    |> NaiveDateTime.to_erl()
    |> Calendar.DateTime.from_erl!("Etc/UTC")
  end

  defp castin(date) do
    date
    |> NaiveDateTime.to_erl()
    |> Calendar.DateTime.from_erl!("Etc/UTC")
  end
end
