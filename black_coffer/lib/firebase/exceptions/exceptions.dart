class signupWithEmailandPasswordexceptions {
  final String message;

  const signupWithEmailandPasswordexceptions(
      [this.message = "An Unknown error occurred."]);

  factory signupWithEmailandPasswordexceptions.code(String code) {
    switch (code) {
      case 'weak-password':
        return signupWithEmailandPasswordexceptions(
            'Please enter a strong password');
      case 'invalid-email':
        return signupWithEmailandPasswordexceptions('Email entered is invalid');
      case 'email-already-in-user':
        return signupWithEmailandPasswordexceptions(
            'Email entered is already been registered');
      case 'operation-not-allowed':
        return signupWithEmailandPasswordexceptions(
            'Operation is not allowed. Please contact support');
      case 'user-disabled':
        return signupWithEmailandPasswordexceptions(
            'This user is disabled. Please contact support');
      default:
        return signupWithEmailandPasswordexceptions();
    }
  }
}
