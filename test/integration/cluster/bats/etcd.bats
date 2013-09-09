# vim: ft=sh:


@test "we should be able to set value" {
  curl -L http://127.0.0.1:4001/v1/keys/message -d value="Hello world"
}

@test "we should be able to get a value" {
  curl -L http://127.0.0.1:4001/v1/keys/message
}

@test "we should be able to delete a key" {
  curl -L http://127.0.0.1:4001/v1/keys/message -X DELETE
}
