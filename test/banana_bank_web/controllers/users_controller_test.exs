defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  alias BananaBank.Users.User

  import BananaBank.Factory

  import Mox

  setup :verify_on_exit!

  describe "create/2" do
    test "sucessfully creates an user", %{conn: conn} do
      params = %{
        name: "John Doe",
        email: "john@gmail.com",
        password: "123456",
        cep: "12345678"
      }

      body = %{
        "bairro" => "",
        "cep" => "29560-000",
        "complemento" => "",
        "ddd" => "28",
        "gia" => "",
        "ibge" => "3202306",
        "localidade" => "Guaçuí",
        "logradouro" => "",
        "siafi" => "5645",
        "uf" => "ES"
      }
      expect(BananaBank.ViaCep.ClientMock, :call, fn _cep->
        {:ok,body}
      end)
      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

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
      expect(BananaBank.ViaCep.ClientMock, :call, fn _cep->
        {:ok,""}
      end)
      response =
        conn
        |> post(~p"/api/users/", params)
        |> json_response(400)
      expected_response = %{"errors" => %{"cep" => ["should be 8 character(s)"], "name" => ["can't be blank"]}}
      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "sucessfully deletes an user", %{conn: conn} do
      %User{id: id} = insert(:user, password: "1234")

      response =
        conn
        |> delete(~p"/api/users/#{id}")
        |> json_response(200)

      expected_response =%{"message" => "Usuário John Doe foi deletado com sucesso!"}

      assert response == expected_response
    end
  end
end
