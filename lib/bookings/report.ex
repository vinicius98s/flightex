defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.Booking

  def create(from_date, to_date) do
    bookings =
      BookingsAgent.get_all_bookings()
      |> Enum.filter(&compare_from_date(&1, from_date))
      |> Enum.filter(&compare_to_date(&1, to_date))
      |> Enum.map(&booking_string/1)

    report_result(File.write("report.csv", bookings))
  end

  defp report_result(:ok), do: {:ok, "Report generated successfully"}
  defp report_result(_), do: {:error, "Failed to generate report"}

  # When the given booking_date is before the from_date, returns false
  defp compare_from_date(%Booking{date: booking_date}, %NaiveDateTime{} = from_date) do
    case NaiveDateTime.compare(booking_date, from_date) do
      :lt -> false
      _ -> true
    end
  end

  # When the given booking_date is after the to_date, returns false 
  defp compare_to_date(%Booking{date: booking_date}, %NaiveDateTime{} = to_date) do
    case NaiveDateTime.compare(booking_date, to_date) do
      :gt -> false
      _ -> true
    end
  end

  defp booking_string(%Booking{
         id: id,
         origin_city: origin_city,
         destination_city: destination_city,
         date: date
       }) do
    "#{id},#{origin_city},#{destination_city},#{date}\n"
  end
end
