defmodule ExreposWeb.FallbackControllerTest do
  use ExreposWeb.ConnCase, async: true

  alias Exrepos.Error
  alias ExreposWeb.FallbackController

  describe "call/2" do
    test "when called, returns an error", %{conn: conn} do
      response =
        FallbackController.call(conn, {:error, %Error{result: "test", status: :bad_request}})

      assert json_response(response, 400) == %{"message" => "test"}
    end
  end
end
