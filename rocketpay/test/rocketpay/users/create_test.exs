defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, retuns an user" do
      params = %{
        name: "Lucas",
        password: "123465",
        nickname: "Pew",
        email: "lucas@pew.com",
        age: 25
      }

      {:ok, %User{id: user_id }} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Lucas", age: 25, id: ^user_id} = user
    end

    test "when there are invalid params, retuns an user" do
      params = %{
        name: "Lucas",
        nickname: "Pew",
        email: "lucas@pew.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response =%{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }
      assert errors_on(changeset) == expected_response
    end
  end
end
