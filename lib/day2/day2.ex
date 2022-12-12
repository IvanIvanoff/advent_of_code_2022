defmodule AOC2022.Day2 do
  def run_part_one() do
    # Transform every line to rock/paper/scissors values
    data(&mapping_function_part_one/1)
    |> Enum.map(&play_and_score/1)
    |> Enum.sum()
  end

  def run_part_two() do
    # Transform every line to rock/paper/scissors values
    data(&mapping_function_part_two/1)
    |> Enum.map(&play_and_score/1)
    |> Enum.sum()
  end

  defp play_and_score([opponent, me]) do
    # 0 = tie, 1 = opponent wins, 2 = me wins
    # the values do not matter as long as they are 3 consecutive numbers
    case rem(3 + to_number(opponent) - to_number(me), 3) do
      0 -> 3 + to_number(me)
      1 -> 0 + to_number(me)
      2 -> 6 + to_number(me)
    end
  end

  defp to_number(:rock), do: 1
  defp to_number(:paper), do: 2
  defp to_number(:scissors), do: 3

  defp data(mapping_fun) when is_function(mapping_fun, 1) do
    Path.join([__DIR__, "data.txt"])
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, " ", trim: true)
      |> mapping_fun.()
    end)
  end

  defp mapping_function_part_one(list) do
    list
    |> Enum.map(fn
      v when v in ["A", "X"] -> :rock
      v when v in ["B", "Y"] -> :paper
      v when v in ["C", "Z"] -> :scissors
    end)
  end

  defp mapping_function_part_two([left, right]) do
    # X = lose, Y = draw, Z = win
    case right do
      "X" -> [left, what_loses_to(left)]
      "Y" -> [left, left]
      "Z" -> [left, what_beats(left)]
    end
    |> mapping_function_part_one()
  end

  @list ["A", "B", "C", "A", "B", "C"]
  @rev_list Enum.reverse(@list)
  # option is beaten by the one on the right of it
  def what_beats(option),
    do: Enum.at(@list, Enum.find_index(@list, &(&1 == option)) + 1)

  # option beats the one by the one on left of it
  def what_loses_to(option),
    do: Enum.at(@rev_list, Enum.find_index(@rev_list, &(&1 == option)) + 1)
end
