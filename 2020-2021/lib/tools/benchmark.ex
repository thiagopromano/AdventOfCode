defmodule Benchmark do
  def benchmark() do
    Benchee.run(%{
      "p1" => fn -> Y2021.D11.p1() end,
      "p2" => fn -> Y2021.D11.p2() end,
    })
    nil
  end
end
