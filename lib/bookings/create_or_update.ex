defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings
  alias Bookings.Agent, as: BookingsAgent
  alias Bookings.Booking

  def create(user_id, %{
        date: date,
        origin_city: origin_city,
        destination_city: destination_city
      }) do
    Booking.build(date, origin_city, destination_city, user_id)
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{id: id} = booking}) do
    BookingsAgent.save(booking)

    {:ok, id}
  end

  defp save_booking({:error, _reason} = error), do: error
end
