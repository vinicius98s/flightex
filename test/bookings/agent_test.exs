defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingsAgent

  describe "save/1" do
    test "can save a booking" do
      BookingsAgent.start_link()

      booking = build(:booking)

      assert :ok = BookingsAgent.save(booking)
    end
  end

  describe "get/1" do
    setup do
      BookingsAgent.start_link()
      :ok
    end

    test "can get an existing booking" do
      booking = build(:booking)

      BookingsAgent.save(booking)

      response = BookingsAgent.get(booking.id)

      expected_response = {:ok, booking}

      assert response == expected_response
    end

    test "when there is no booking, returns an error" do
      response = BookingsAgent.get("123")

      expected_response = {:error, "Flight Booking not found"}

      assert response == expected_response
    end
  end

  describe "get_all_bookings/0" do
    test "can get all bookings" do
      BookingsAgent.start_link()

      booking1 = build(:booking, id: "1")
      booking2 = build(:booking, id: "2")

      [booking1, booking2] |> Enum.each(&BookingsAgent.save/1)

      response = BookingsAgent.get_all_bookings()

      expected_response = [booking1, booking2]

      assert response == expected_response
    end
  end
end
