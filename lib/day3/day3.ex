defmodule AOC2022.Day3 do
  def run_part_one() do
    data()
    |> Enum.map(fn line -> String.split_at(line, String.length(line) |> div(2)) end)
    |> Enum.map(&score_part_one/1)
    |> Enum.sum()
  end

  def run_part_two() do
    data()
    |> Enum.chunk_every(3)
    |> Enum.map(&score_part_two/1)
    |> Enum.sum()
  end

  defp score_part_one({com1, com2}) do
    MapSet.intersection(to_set(com1), to_set(com2))
    |> Enum.map(&letter_to_score/1)
    |> Enum.sum()
  end

  defp score_part_two([r1, r2, r3]) do
    MapSet.intersection(to_set(r1), to_set(r2))
    |> MapSet.intersection(to_set(r3))
    |> Enum.to_list()
    |> List.first()
    |> letter_to_score()
  end

  defp to_set(string) do
    string |> String.to_charlist() |> MapSet.new()
  end

  defp letter_to_score(letter) do
    cond do
      letter in ?a..?z -> letter - ?a + 1
      letter in ?A..?Z -> letter - ?A + 27
    end
  end

  defp data() do
    Path.join([__DIR__, "data.txt"])
    |> File.read!()
    |> String.split("\n")
  end
end
