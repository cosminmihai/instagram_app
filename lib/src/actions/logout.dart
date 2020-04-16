class LogOut {}

class LogOutSuccessful {}

class LogOutError {
  const LogOutError(this.error);

  final Object error;
}
