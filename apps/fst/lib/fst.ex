defmodule FST do
  @moduledoc "nif bindings to https://github.com/BurntSushi/fst"
  use Rustler, otp_app: :fst, crate: :fst_nifs

  def from_file_async(path) do
    :ok = from_file(path)

    receive do
      {:ok, _set} = success -> success
      other -> other
    end
  end

  def from_file(_path), do: error()
  def contains?(_set, _query), do: error()

  defp error do
    :erlang.nif_error(:nif_not_loaded)
  end
end
