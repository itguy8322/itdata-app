// ignore_for_file: unnecessary_null_comparison

enum PasswordInputError { empty, invalid }

class PasswordInput {
  String value;
  PasswordInputError? error;
  bool? isValid;
  PasswordInput({required this.value, this.error, this.isValid});

  void validate() {
    final valueRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );
    if (value == '' || value == null) {
      isValid = false;
      error = PasswordInputError.empty;
    } else if (!valueRegExp.hasMatch(value)) {
      isValid = false;
      error = PasswordInputError.invalid;
    } else {
      isValid = true;
      error = null;
    }
  }
}
