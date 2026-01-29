"use strict";

var USERNAME = "${username}";
var PASSWORD = "${password}";
var EXPECTED_AUTH = "Basic " + `$${USERNAME}:$${PASSWORD}`.toString('base64');

function handler(event) {
  var authHeaders = event.request.headers.authorization;
  if (authHeaders && authHeaders.value === EXPECTED_AUTH) {
    return event.request;
  }

  return {
    statusCode: 401,
    statusDescription: "Unauthorized",
    headers: {
      "www-authenticate": {
        value: `Basic realm="Please enter credentials"`,
      },
    },
  };
}
