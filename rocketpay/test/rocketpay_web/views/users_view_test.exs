defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Lucas",
      password: "123465",
      nickname: "Pew",
      email: "lucas@pew.com",
      age: 25
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} =user} =
      Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "user created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Lucas",
        nickname: "Pew"
      }
    }

    assert expected_response == response
  end

end
