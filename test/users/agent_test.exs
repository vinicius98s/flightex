defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UsersAgent

  describe "save/1" do
    test "can save an user" do
      UsersAgent.start_link()

      user = build(:user)

      assert :ok = UsersAgent.save(user)
    end
  end

  describe "get/1" do
    setup do
      UsersAgent.start_link()
      :ok
    end

    test "can get an existing user" do
      user = build(:user)

      UsersAgent.save(user)

      response = UsersAgent.get(user.id)

      expected_response = {:ok, user}

      assert response == expected_response
    end

    test "when there is no user, returns an error" do
      response = UsersAgent.get("123")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
