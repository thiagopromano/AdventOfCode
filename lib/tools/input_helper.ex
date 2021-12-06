defmodule InputHelper do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      defp input_string do
        Process.get("aoc_input_string", super())
      end

      defoverridable input_string: 0
    end
  end

  defmacro setup(input_tring) do
    quote do
      setup do
        Process.put("aoc_input_string", unquote(input_tring))
        on_exit(fn -> Process.delete("aoc_input_string") end)
        :ok
      end
    end
  end
end
