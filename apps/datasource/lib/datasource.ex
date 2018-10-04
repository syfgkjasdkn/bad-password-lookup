defmodule DataSource do
  def txt_path(file) do
    :datasource
    |> Application.app_dir("priv")
    |> Path.join(file)
  end
end
