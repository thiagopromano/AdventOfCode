defmodule MathTools do
  # Does the convolution of two vectors and removes the start and end transient
  def conv(a, b) do
    revB = Enum.reverse(b)

    a
    |> Enum.chunk_every(length(revB), 1)
    |> Enum.map(fn chunk ->
      Enum.zip(chunk, revB)
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
end
