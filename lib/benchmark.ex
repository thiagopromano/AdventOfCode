defmodule Benchmark do
  import AOC
  def benchmark() do
    Benchee.run(%{
      "p1" => fn -> p1() end,
      "p2" => fn -> p2() end,
    })
    nil
  end
end
