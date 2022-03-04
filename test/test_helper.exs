ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Exrepos.Repo, :manual)

Mox.defmock(Exrepos.Github.ClientMock, for: Exrepos.Github.Behaviour)
