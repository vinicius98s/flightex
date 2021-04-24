defmodule Flightex do
  alias Flightex.{Users, Bookings}
  alias Bookings.Agent, as: BookingsAgent
  alias Bookings.CreateOrUpdate, as: BookingsCreateOrUpdate
  alias Users.Agent, as: UsersAgent
  alias Users.CreateOrUpdate, as: UsersCreateOrUpdate

  def start_agents do
    UsersAgent.start_link()
    BookingsAgent.start_link()
  end

  defdelegate create_user(params), to: UsersCreateOrUpdate, as: :create
  defdelegate get_user(id), to: UsersAgent, as: :get

  defdelegate create_booking(user_id, params), to: BookingsCreateOrUpdate, as: :create
  defdelegate get_booking(id), to: BookingsAgent, as: :get
end
