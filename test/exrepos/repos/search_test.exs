defmodule Exrepos.Repos.SearchTest do
  use Exrepos.DataCase, async: true

  import Mox

  alias Exrepos.Github.{ClientMock, Response}
  alias Exrepos.Repos.Search

  describe "call/1" do
    test "when the username is valid, returns the user repos" do
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

      response = Search.call(username)

      assert {:ok, [%Response{name: ^username, stargazers_count: 0}]} = response
    end

    test "when the username is invalid, returns an error" do
      username = "8bitbeard"

      expect(ClientMock, :get_user_repos, fn _username ->
        {:error, %Exrepos.Error{result: "User not found!", status: :not_found}}
      end)

      response = Search.call(username)

      expected_response = {:error, %Exrepos.Error{result: "User not found!", status: :not_found}}

      assert response == expected_response
    end
  end
end
