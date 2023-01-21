enum AuthorizationStatus {
  processing,
  authorized,
  unauthorized,
}

extension AuthorizationStatusExt on AuthorizationStatus {
  bool get isProcessing => this == AuthorizationStatus.processing;

  bool get isAuthorized => this == AuthorizationStatus.authorized;

  bool get isUnauthorized => this == AuthorizationStatus.unauthorized;
}
