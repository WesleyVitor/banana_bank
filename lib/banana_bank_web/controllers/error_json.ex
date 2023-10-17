defmodule BananaBankWeb.ErrorJSON do
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def error(%{status: :not_found}) do
    %{
      message: "Usuário não encontrado!",
      status: :not_found
    }
  end
  def error(%{status: :unauthorized}) do
    %{
      message: "Usuário não autenticado!",
      status: :unauthorized
    }
  end

  def error(%{status: :bad_request}) do
    %{
      message: "Ocorreu algum erro no sistema!",
      status: :bad_request
    }
  end
  def error(%{message: message}) do
    %{
      message: message,
      status: :bad_request
    }
  end

  def error(%{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  defp translate_error({msg, opts}) do
    Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
      opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
    end)
  end
end
