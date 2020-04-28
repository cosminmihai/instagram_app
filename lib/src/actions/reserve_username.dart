class ReserveUsername {}

class ReserveUsernameSuccessful {
  ReserveUsernameSuccessful(this.username);

  final String username;
}

class ReserveUsernameError {
  ReserveUsernameError(this.error);

  final Object error;
}
