defmodule Exrepos.Github.ClientTest do
  use ExUnit.Case, async: true

  alias Exrepos.Error
  alias Exrepos.Github.{Client, Response}
  alias Plug.Conn

  describe "get_user_repos/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is an valid username, returns the user repos", %{bypass: bypass} do
      username = "8bitbeard"

      url = endpoint_url(bypass.port)

      body = ~s([{
        "id": 393488591,
        "node_id": "MDEwOlJlcG9zaXRvcnkzOTM0ODg1OTE=",
        "name": "8bitbeard",
        "full_name": "8bitbeard/8bitbeard",
        "html_url": "https://github.com/8bitbeard/8bitbeard",
        "fork": false,
        "url": "https://api.github.com/repos/8bitbeard/8bitbeard",
        "forks_url": "https://api.github.com/repos/8bitbeard/8bitbeard/forks",
        "keys_url": "https://api.github.com/repos/8bitbeard/8bitbeard/keys{/key_id}",
        "description": null,
        "created_at": "2021-08-06T19:58:56Z",
        "updated_at": "2022-02-04T17:18:19Z",
        "pushed_at": "2022-02-04T17:18:16Z",
        "git_url": "git://github.com/8bitbeard/8bitbeard.git",
        "ssh_url": "git@github.com:8bitbeard/8bitbeard.git",
        "clone_url": "https://github.com/8bitbeard/8bitbeard.git",
        "svn_url": "https://github.com/8bitbeard/8bitbeard",
        "stargazers_count": 0
      }])

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_user_repos(url, username)

      expected_response =
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

      assert response == expected_response
    end

    test "when there is an invalid username, returns an error", %{bypass: bypass} do
      username = "inexistenrosaiu"

      url = endpoint_url(bypass.port)

      body = ~s({
        "message": "Not Found",
        "documentation_url": "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user"
      })

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, body)
      end)

      response = Client.get_user_repos(url, username)

      expected_response = {:error, %Error{result: "User not found!", status: :not_found}}

      assert response == expected_response
    end

    test "when there is a generic error, returns an error", %{bypass: bypass} do
      username = "8bitbeard"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_user_repos(url, username)

      expected_response = {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
