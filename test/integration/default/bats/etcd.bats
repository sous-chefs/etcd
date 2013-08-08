# vim: ft=sh:
# only run on rhel
@test "we should be able to store a value" {
  curl -L http://127.0.0.1:4001/v1/keys/message -d value="Hello world"
}

@test "we should be able to get a value" {
  curl -L http://127.0.0.1:4001/v1/keys/message
}
