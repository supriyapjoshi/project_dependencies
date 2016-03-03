defmodule Helpers do
  defmacro left >>> right do
    quote do
      (fn ->
        case unquote(left) do
          {:ok,x} ->x |> unquote(right)
          {:error,_} =  expr -> expr
        end
      end).()
    end
  end
end
