defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Booking

  describe "build/5" do
    test "when given the right params, builds a booking" do
      response =
        Booking.build(
          "987654321",
          ~N[2021-04-30 10:04:00],
          "São Paulo",
          "Rio de Janeiro",
          "123456789"
        )

      booking = build(:booking)

      expected_response = {:ok, booking}

      assert response == expected_response
    end

    test "when given wrong params, returns an error" do
      response =
        Booking.build("987654321", "Invalid date", "São Paulo", "Rio de Janeiro", "123456789")

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
