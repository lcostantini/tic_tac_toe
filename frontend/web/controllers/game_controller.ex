defmodule FrontTicTac.GameController do
  use FrontTicTac.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
