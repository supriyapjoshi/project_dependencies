defmodule JavaProjectDependencies do
  def filterImportFunc do
    fn val -> if Regex.match?(~r/^import.*$/,val), do: val end #
  end
  def extract(string) do
    String.split(string, "\n")
  end

  def filterImports([head | tail]) do
    _findImports([head | tail],[])
  end


  defp _findImports([head],[]), do: [filterImportFunc.(head)]

  defp _findImports([head | tail], []), do: _findImports(tail, [filterImportFunc.(head) | []])

  defp _findImports([head | tail], imports), do: _findImports(tail,  [ filterImportFunc.(head) | imports])

  defp _findImports([] ,imports), do: Enum.filter_map(imports, filterNil, replaceImport)

  def readFile(file_name) do
    {:ok, result} = File.read(file_name)
  end 

  def splitData(file_data) do
    try do
      String.split(file_data, "\n")
    rescue [FunctionClauseError] -> {:error,"Empty string received"}
    end
  end

  def process(file) do
    import Helpers
    readFile(file) 
    >>> splitData()
    |> filterImports() 
    |> IO.inspect
  end

  def filterNil do
    fn(x) -> x != nil end
  end

  def replaceImport do
    fn(x) -> String.replace(x, "import ", "") end
  end


end
