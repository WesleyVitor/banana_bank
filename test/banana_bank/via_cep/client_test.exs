defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client, as: ViaCepClient
  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/2" do
    test "success request", %{bypass: bypass}do
      cep = "59300000"
      url = "#{endpoint_url(bypass.port)}/#{cep}/json"
      body = ~s(
        {
          "bairro" : "",
          "cep" : "59300-000",
          "complemento" : "",
          "ddd" : "84",
          "gia" : "",
          "ibge" : "2402006",
          "localidade" : "Caicó",
          "logradouro" : "",
          "siafi" : "1639",
          "uf" : "RN"
        }
      )
      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)
      expected_response = %{
        "bairro" => "",
        "cep" => "59300-000",
        "complemento" => "",
        "ddd" => "84",
        "gia" => "",
        "ibge" => "2402006",
        "localidade" => "Caicó",
        "logradouro" => "",
        "siafi" => "1639",
        "uf" => "RN"
      }

      {_, response} =
        bypass.port
        |> endpoint_url()
        |> ViaCepClient.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
