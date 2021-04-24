defmodule Flightex.Bookings.Booking do
  @keys [:id, :date, :origin_city, :destination_city, :user_id]

  @enforce_keys @keys

  defstruct @keys

  def build(%NaiveDateTime{} = date, origin_city, destination_city, user_id) do
    id = UUID.uuid4()

    {:ok,
     %__MODULE__{
       id: id,
       date: date,
       origin_city: origin_city,
       destination_city: destination_city,
       user_id: user_id
     }}
  end

  def build(_date, _origin_city, _destination_city, _user_id), do: {:error, "Invalid parameters"}
end
