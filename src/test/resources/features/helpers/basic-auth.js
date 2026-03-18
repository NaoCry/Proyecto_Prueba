function fn(credentials) {
  var raw = credentials.username + ':' + credentials.password;
  var token = java.util.Base64.getEncoder().encodeToString(raw.getBytes());
  return { value: 'Basic ' + token };
}
