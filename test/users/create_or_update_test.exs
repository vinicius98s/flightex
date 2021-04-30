defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Flightex.Users.CreateOrUpdate
  alias Flightex.Users.Agent, as: UsersAgent

  describe "create/1" do
    setup do
      UsersAgent.start_link()
      :ok
    end

    test "when given correct params, saves the user" do
      params = %{
        name: "Vinicius",
        email: "vinicius@sales.com",
        cpf: "12345678900"
      }

      response = CreateOrUpdate.create(params)
      assert {:ok, _id} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Vinicius",
        email: "vinicius@sales.com",
        cpf: 12_345_678_900
      }

      response = CreateOrUpdate.create(params)
      assert {:error, _reason} = response
    end
  end
end
