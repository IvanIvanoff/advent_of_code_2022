defmodule AOC2022.Day1 do
  def run_part_one() do
    data()
    |> sum_top_k(1)
  end

  def run_part_two() do
    data()
    |> sum_top_k(3)
  end

  defp sum_top_k(data, k) do
    data
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort(:desc)
    |> Enum.take(k)
    |> Enum.sum()
  end

  defp data() do
    Path.join([__DIR__, "data.txt"])
    |> File.read!()
    |> String.split("\n")
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.reject(&(&1 == [""]))
    |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
  end
end
