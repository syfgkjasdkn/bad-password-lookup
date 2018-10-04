defmodule PasswordBench do
  @passwords_txt DataSource.txt_path("sorted_passwords.txt")

  @passwords [
    "hello",
    "qwerty",
    "this_is_a_good_password",
    "123456"
  ]

  def bench([password | rest], callback) do
    callback.(password)
    bench(rest, callback)
  end

  def bench([], _callback) do
    :ok
  end

  def control do
    fn ->
      PasswordBench.bench(@passwords, fn _ -> true end)
    end
  end

  def fst do
    {:ok, passwords_fst} = FST.from_file_async(@passwords_txt)

    fn ->
      PasswordBench.bench(@passwords, fn password ->
        FST.contains?(passwords_fst, password)
      end)
    end
  end

  def in_memory_ets do
    table = :in_memory_ets = :ets.new(:in_memory_ets, [:named_table])

    @passwords_txt
    |> File.stream!()
    |> Enum.each(fn password ->
      :ets.insert(table, {String.trim(password)})
    end)

    fn ->
      PasswordBench.bench(@passwords, fn password ->
        :ets.member(table, password)
      end)
    end
  end
end

Benchee.run(%{
  "control" => PasswordBench.control(),
  "fst" => PasswordBench.fst(),
  "in_memory_ets" => PasswordBench.in_memory_ets()
})
