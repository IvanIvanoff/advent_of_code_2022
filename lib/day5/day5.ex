defmodule AOC2022.Day5 do
  def run_part_one() do
    data()
    |> apply_moves(&Enum.reverse/1)
    |> get_top_of_stack_string()
  end

  def run_part_two() do
    data()
    |> apply_moves(& &1)
    |> get_top_of_stack_string()
  end

  defp apply_moves(%{stack: stack, moves: moves}, order_fun) when is_function(order_fun, 1) do
    moves
    |> Enum.reduce(stack, fn move, acc ->
      %{count: count, from: from, to: to} = move

      {popped, rest} = acc[from] |> Enum.split(count)

      %{
        acc
        | from => rest,
          to => order_fun.(popped) ++ acc[to]
      }
    end)
  end

  defp get_top_of_stack_string(map) do
    map
    |> Enum.map(fn {k, v} -> {k, List.first(v)} end)
    |> Enum.sort_by(fn {k, _v} -> k end, :asc)
    |> Enum.map(fn {_k, v} -> v end)
    |> Enum.join()
  end

  defp data() do
    [stack, moves] =
      Path.join([__DIR__, "data.txt"])
      |> File.read!()
      |> String.split("\n\n")

    %{stack: parse_stack(stack), moves: parse_moves(moves)}
  end

  defp parse_stack(stack) do
    stack
    |> String.split("\n")
    |> Enum.drop(-1)
    |> Enum.reduce(%{}, fn line, acc ->
      line
      |> String.graphemes()
      |> Enum.chunk_every(4)
      |> Enum.map(&Enum.at(&1, 1))
      |> Enum.with_index(1)
      |> Enum.reduce(acc, fn
        {" ", _index}, acc -> acc
        # Top of the stack is at pos 0, as working with the beginning
        # of a list is faster than with the end
        {val, index}, acc -> Map.update(acc, index, [val], &(&1 ++ [val]))
      end)
    end)
  end

  defp parse_moves(moves) do
    regex = ~r/move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)/

    moves
    |> String.split("\n")
    |> Enum.map(fn line ->
      %{"count" => c, "from" => f, "to" => t} = Regex.named_captures(regex, line)
      to_int = &String.to_integer/1
      %{count: to_int.(c), from: to_int.(f), to: to_int.(t)}
    end)
  end
end
