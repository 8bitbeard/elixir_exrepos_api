defmodule ExreposWeb.ReposControllertest do
  use ExreposWeb.ConnCase, async: true

  import Mox

  alias Exrepos.Github.{ClientMock, Response}

  describe "search/2" do
    test "when the username parameter is valid, returns the user repos", %{conn: conn} do
      username = "8bitbeard"

      expect(ClientMock, :get_user_repos, fn _username ->
        {:ok,
         [
           %Response{
             description: nil,
             html_url: "https://github.com/8bitbeard/8bitbeard",
             id: 393_488_591,
             name: "8bitbeard",
             stargazers_count: 0
           }
         ]}
      end)

      response =
        conn
        |> get(Routes.repos_path(conn, :search, username))
        |> json_response(:ok)

      assert %{
               "repos" => [
                 %{
                   "description" => nil,
                   "html_url" => "https://github.com/8bitbeard/8bitbeard",
                   "id" => 393_488_591,
                   "name" => ^username,
                   "stargazers_count" => 0
                 }
               ]
             } = response
    end

    test "when the username dont exists, returns an error", %{conn: conn} do
      username = "inexistent"

      expect(ClientMock, :get_user_repos, fn _username ->
        {:error, %Exrepos.Error{result: "User not found!", status: :not_found}}
      end)

      response =
        conn
        |> get(Routes.repos_path(conn, :search, username))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found!"}

      assert response == expected_response
    end
  end
end
