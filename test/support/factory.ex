defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def booking_factory do
    %Booking{
      id: "987654321",
      date: ~N[2021-04-30 10:04:00],
      origin_city: "São Paulo",
      destination_city: "Rio de Janeiro",
      user_id: "123456789"
    }
  end

  def user_factory do
    %User{
      id: "123456789",
      name: "Vinicius",
      email: "vinicius@sales.com",
      cpf: "12345678900"
    }
  end
end
