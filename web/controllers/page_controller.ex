defmodule ProjectDependencies.PageController do
  use ProjectDependencies.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
