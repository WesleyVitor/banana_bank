defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  describe "create/2" do
    test "sucessfully creates an user", %{conn: conn} do
      params = %{
        name: "John Doe",
        email: "john@gmail.com",
        password: "123456",
        cep: "12345678"
      }

      response =
        conn
        |> post(~p"/api/users/", params)
        |> json_response(201)

      assert %{
               "data" => %{"cep" => "12345678", "email" => "john@gmail.com", "id" => _id, "name" => "John Doe"},
               "message" => "Usuário criado com sucesso!"
             } = response
    end
    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        name: nil,
        email: "john@gmail.com",
        password: "123456",
        cep: "123"
      }

      response =
        conn
        |> post(~p"/api/users/", params)
        |> json_response(400)
      expected_response = %{"errors" => %{"cep" => ["should be 8 character(s)"], "name" => ["can't be blank"]}}
      assert response == expected_response
    end
  end
end
