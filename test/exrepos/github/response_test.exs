defmodule Exrepos.Github.ResponseTest do
  use ExUnit.Case, async: true

  alias Exrepos.Github.Response

  describe "build/1" do
    test "when a valid map is passed, returns the struct" do
      input_map = %{
        "id" => 393_488_591,
        "node_id" => "MDEwOlJlcG9zaXRvcnkzOTM0ODg1OTE=",
        "name" => "8bitbeard",
        "full_name" => "8bitbeard/8bitbeard",
        "html_url" => "https://github.com/8bitbeard/8bitbeard",
        "fork" => false,
        "url" => "https://api.github.com/repos/8bitbeard/8bitbeard",
        "forks_url" => "https://api.github.com/repos/8bitbeard/8bitbeard/forks",
        "keys_url" => "https://api.github.com/repos/8bitbeard/8bitbeard/keys{/key_id}",
        "description" => nil,
        "created_at" => "2021-08-06T19:58:56Z",
        "updated_at" => "2022-02-04T17:18:19Z",
        "pushed_at" => "2022-02-04T17:18:16Z",
        "git_url" => "git://github.com/8bitbeard/8bitbeard.git",
        "ssh_url" => "git@github.com:8bitbeard/8bitbeard.git",
        "clone_url" => "https://github.com/8bitbeard/8bitbeard.git",
        "svn_url" => "https://github.com/8bitbeard/8bitbeard",
        "stargazers_count" => 0
      }

      response = Response.build(input_map)

      expected_response = %Response{
        id: 393_488_591,
        name: "8bitbeard",
        description: nil,
        html_url: "https://github.com/8bitbeard/8bitbeard",
        stargazers_count: 0
      }

      assert response == expected_response
    end
  end
end
