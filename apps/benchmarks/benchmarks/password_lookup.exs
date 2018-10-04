defmodule PasswordBench do
  @passwords_txt DataSource.txt_path("sorted_passwords.txt")

  @passwords @passwords_txt
             |> File.stream!()
             |> Stream.map(&String.trim/1)
             |> Enum.take_random(500)

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

  def bloomex do
    bf = Bloomex.scalable(1_000_000, 0.1, 0.1, 2)

    @passwords_txt
    |> File.stream!()
    |> Enum.each(fn password ->
      Bloomex.add(bf, String.trim(password))
    end)

    fn ->
      PasswordBench.bench(@passwords, fn password ->
        Bloomex.member?(bf, password)
      end)
    end
  end

  def flower do
    bf = Flower.Bloom.new(:"2 MB", 1_000_000)

    @passwords_txt
    |> File.stream!()
    |> Enum.each(fn password ->
      Flower.Bloom.insert(bf, String.trim(password))
    end)

    fn ->
      PasswordBench.bench(@passwords, fn password ->
        Flower.Bloom.has?(bf, password)
      end)
    end
  end
end

Benchee.run(%{
  "control" => PasswordBench.control(),
  "fst" => PasswordBench.fst(),
  "in_memory_ets" => PasswordBench.in_memory_ets(),
  "bloomex" => PasswordBench.bloomex(),
  "flower (rust bloom)" => PasswordBench.flower()
})
