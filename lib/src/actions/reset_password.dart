typedef ActionResult = void Function(dynamic action);

class ResetPassword {
  ResetPassword(this.email, this.actionResult);

  final ActionResult actionResult;
  final String email;
}

class ResetPasswordSuccessful {}

class ResetPasswordError {
  const ResetPasswordError(this.error);

  final Object error;
}
