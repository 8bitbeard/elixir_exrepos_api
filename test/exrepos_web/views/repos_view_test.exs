defmodule ExreposWeb.ReposViewTest do
  use ExreposWeb.ConnCase, async: true

  import Phoenix.View

  alias Exrepos.Github.Response
  alias ExreposWeb.ReposView

  test "renders search.json" do
    repos = [
      %Response{
        id: 123,
        name: "Mock",
        description: "Mock Desc",
        html_url: "https://mock.url.com",
        stargazers_count: 10
      }
    ]

    response = render(ReposView, "search.json", repos: repos)

    assert %{
             repos: [
               %{
                 id: 123,
                 name: "Mock",
                 description: "Mock Desc",
                 html_url: "https://mock.url.com",
                 stargazers_count: 10
               }
             ]
           } = response
  end
end
