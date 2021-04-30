defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Users.Agent, as: UsersAgent

  describe "create/2" do
    setup do
      Flightex.start_agents()

      user = build(:user)
      UsersAgent.save(user)

      params = %{
        date: ~N[2021-04-30 11:25:00],
        origin_city: "Bahia",
        destination_city: "Paris"
      }

      {:ok, user: user, params: params}
    end

    test "when given correct params, saves the booking", %{user: user, params: params} do
      response = CreateOrUpdate.create(user.id, params)
      assert {:ok, _id} = response
    end

    test "when there are invalid params, returns an error", %{user: user, params: valid_params} do
      params = %{valid_params | date: "Invalid date"}
      response = CreateOrUpdate.create(user.id, params)
      assert {:error, _reason} = response
    end

    test "when given an user that doesn't exist, returns an error", %{params: params} do
      response = CreateOrUpdate.create("123", params)
      assert {:error, "User not found"} = response
    end
  end
end
