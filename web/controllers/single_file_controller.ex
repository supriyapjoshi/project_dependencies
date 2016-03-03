defmodule ProjectDependencies.SingleFileController do
  use ProjectDependencies.Web, :controller
    def index(conn, %{"file_name" => file_name} = params) do
      
      render conn, "index.html", file_name: file_name
    end
end
