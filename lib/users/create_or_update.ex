defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users
  alias Users.Agent, as: UserAgent
  alias Users.User

  def create(%{name: name, email: email, cpf: cpf}) do
    id = UUID.uuid4()

    User.build(id, name, email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{id: id} = user}) do
    UserAgent.save(user)

    {:ok, id}
  end

  defp save_user({:error, _reason} = error), do: error
end
