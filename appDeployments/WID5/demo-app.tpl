module.exports = {
  HOST: "{{ secret "address" }}",
  USER: "{{ secret "username" }}",
  PASSWORD: "{{ secret "password" }}",
  DB: "{{ secret "Database" }}",
  PORT: "{{ secret "Port" }}"
};