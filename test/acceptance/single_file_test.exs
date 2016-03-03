defmodule ProjectDependencies.Acceptance.SingleFileTest do
  use ExUnit.Case
  use Hound.Helpers
  hound_session
  
  test "/single_file has a list of dependencies for single file" do
    navigate_to "/single_file"
    assert find_element(:css, "div")
  end
end 
