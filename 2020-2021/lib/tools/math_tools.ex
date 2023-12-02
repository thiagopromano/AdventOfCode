defmodule MathTools do
  # Does the convolution of two vectors and removes the start and end transient
  def conv(a, b) do
    rev_b = Enum.reverse(b)

    a
    |> Enum.chunk_every(length(rev_b), 1)
    |> Enum.map(fn chunk ->
      Enum.zip(chunk, rev_b)
      |> Enum.map(fn {a, b} -> a * b end)
      |> Enum.sum()
    end)
  end

  def pointwise_sum(a, b) do
    Enum.zip(a, b)
    |> Enum.map(fn {a, b} -> a + b end)
  end

  def transpose([]), do: []
  def transpose([[] | _]), do: []

  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

  def arithmetic_series_sum(a, b) when a > b, do: arithmetic_series_sum(b, a)

  def arithmetic_series_sum(a, b) do
    (b - a + 1) * (a + b) / 2
  end

  def permutations([]), do: [[]]
  def permutations(list),
    do: for(elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest])
end
