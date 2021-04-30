defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings
  alias Flightex.Users.Agent, as: UsersAgent
  alias Bookings.Agent, as: BookingsAgent
  alias Bookings.Booking

  def create(user_id, params) do
    case UsersAgent.get(user_id) do
      {:ok, _user} -> create_booking(user_id, params)
      error -> error
    end
  end

  defp create_booking(user_id, %{
         date: date,
         origin_city: origin_city,
         destination_city: destination_city
       }) do
    id = UUID.uuid4()

    Booking.build(id, date, origin_city, destination_city, user_id)
    |> save_booking()
  end

  defp create_booking(_user_id, _params), do: {:error, "Invalid parameters"}

  defp save_booking({:ok, %Booking{id: id} = booking}) do
    BookingsAgent.save(booking)

    {:ok, id}
  end

  defp save_booking({:error, _reason} = error), do: error
end
