defmodule JavaProjectDependenciesTest do
  use ExUnit.Case
  doctest JavaProjectDependencies

  test "converts the data string into array" do
    expected = ["This is a string;"," This has multiple lines of data"]
    assert JavaProjectDependencies.extract("This is a string;\n This has multiple lines of data") == expected
  end

  test "it matches the regex for import when its present" do
    expected = ["import com.test.bla.bla"]
    input = ["import com.test.bla.bla"]
    assert elem(JavaProjectDependencies.filterImports(input), 1) == expected
  end

  test "it matches multiple import statements when present" do
    expected = ["bla.bla.3", "bla.bla.2;", "bla.bla.1;"]
    input = ["import bla.bla.1;","import bla.bla.2;", "import bla.bla.3"]
    assert elem(JavaProjectDependencies.filterImports(input),1) == expected
  end

  test "it ignores the statements that dont match" do
    expected = {:ok, ["bla.bla.2", "bla.bla.1"]}
    input = ["package bla;", "import bla.bla.1", "import bla.bla.2"]
    assert JavaProjectDependencies.filterImports(input) == expected
  end

  test "it creates the list of only imported packages, ignoring the word import" do
    expected = {:ok, ["bla.bla.1", "bla.bla.2"]}
    input = ["import bla.bla.2", "import bla.bla.1"]
    assert JavaProjectDependencies.filterImports(input) == expected
  end

  test "it gives an error if it is unable to split the string" do
    input = nil
    expected = {:error, "Empty string received"}
    assert JavaProjectDependencies.splitData(input) == expected 
  end

  test "it gives an error in process if there is an error reading the file or reading data" do
    expected = {:error, :enoent}
    assert JavaProjectDependencies.process("file_name") == expected
  end
end
