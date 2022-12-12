defmodule AOC2022.Day4 do
  def run_part_one() do
    data()
    |> Enum.map(fn [r1, r2] -> range_contains?(r1, r2) or range_contains?(r2, r1) end)
    |> Enum.count(fn bool -> bool == true end)
  end

  def run_part_two() do
    data()
    |> Enum.map(fn [r1, r2] -> ranges_overlap?(r1, r2) end)
    |> Enum.count(fn bool -> bool == true end)
  end

  defp range_contains?(l1..h1, l2..h2), do: l1 <= l2 and h1 >= h2
  defp ranges_overlap?(r1, r2), do: not Range.disjoint?(r1, r2)

  defp data() do
    Path.join([__DIR__, "data.txt"])
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(fn range ->
        [l, h] =
          range
          |> String.split("-")
          |> Enum.map(&String.to_integer/1)

        l..h
      end)
    end)
  end
end
