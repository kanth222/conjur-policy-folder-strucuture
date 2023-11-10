module.exports = {
  HOST: "{{ secret "WebApplicationID" }}",
  USER: "{{ secret "address" }}",
  PASSWORD: "{{ secret "username" }}",
  DB: "{{ secret "password" }}",
  PORT: "{{ secret "Port" }}"
};