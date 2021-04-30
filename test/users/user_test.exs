defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.User

  describe "build/4" do
    test "when given the right params, builds an user" do
      response =
        User.build(
          "123456789",
          "Vinicius",
          "vinicius@sales.com",
          "12345678900"
        )

      user = build(:user)

      expected_response = {:ok, user}

      assert response == expected_response
    end

    test "when given wrong params, returns an error" do
      response =
        User.build(
          "123456789",
          "Vinicius",
          "vinicius@sales.com",
          12_345_678_900
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
