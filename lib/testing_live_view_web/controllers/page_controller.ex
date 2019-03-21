defmodule TestingLiveViewWeb.PageController do
  use TestingLiveViewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
