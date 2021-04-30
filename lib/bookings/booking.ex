defmodule Flightex.Bookings.Booking do
  @keys [:id, :date, :origin_city, :destination_city, :user_id]

  @enforce_keys @keys

  defstruct @keys

  def build(id, %NaiveDateTime{} = date, origin_city, destination_city, user_id) do
    {:ok,
     %__MODULE__{
       id: id,
       date: date,
       origin_city: origin_city,
       destination_city: destination_city,
       user_id: user_id
     }}
  end

  def build(_id, _date, _origin_city, _destination_city, _user_id),
    do: {:error, "Invalid parameters"}
end
