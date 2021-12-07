defmodule InputHelper do
  @input_string_const "aoc_input_string"
  defmacro __using__(_opts) do
    quote location: :keep do
      defp input_string do
        Process.get("aoc_input_string", super())
      end

      defoverridable input_string: 0
    end
  end

  defmacro setup(input_tring) do
    quote location: :keep do
      setup do
        InputHelper.set_input_string(unquote(input_tring))
        on_exit(&InputHelper.clear_input_string/0)
        :ok
      end
    end
  end
  def set_input_string(input_string) do
    Process.put(@input_string_const, input_string)
  end
  def clear_input_string() do
    Process.delete("aoc_input_string")
  end
end
