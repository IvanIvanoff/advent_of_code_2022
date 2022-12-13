defmodule AOC2022.Day6 do
  def run_part_one(), do: data() |> find_position(4)

  def run_part_two(), do: data() |> find_position(14)

  defp find_position(str, distinct), do: do_find_position(str, distinct, distinct)

  defp do_find_position(<<_::utf8, rest::binary>> = str, sequence_length, pos) do
    set = String.split_at(str, sequence_length) |> elem(0) |> String.graphemes() |> MapSet.new()

    case MapSet.size(set) do
      ^sequence_length -> pos
      _ -> do_find_position(rest, sequence_length, pos + 1)
    end
  end

  defp data() do
    Path.join([__DIR__, "data.txt"])
    |> File.read!()
  end
end
