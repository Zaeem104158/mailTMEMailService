// ignore_for_file: constant_identifier_names

enum Environment {
  STAGING,
  PRODUCTION,
}

const Environment activeProfile = Environment.PRODUCTION;

String getBaseUrl() {
  switch (activeProfile) {
    case Environment.STAGING:
      return "https://api.mail.tm";

    case Environment.PRODUCTION:
      return "https://api.mail.tm";
  }
}

enum HttpMethod {
  GET,
  POST,
  PUT,
}
