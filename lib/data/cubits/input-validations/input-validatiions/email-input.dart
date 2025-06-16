// ignore_for_file: unnecessary_null_comparison

enum EmailInputError { empty, invalid }

class EmailInput {
  String value;
  EmailInputError? error;
  bool? isValid;
  EmailInput({required this.value, this.error, this.isValid});

  void validate() {
    final RegExp valueRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (value == '' || value == null) {
      isValid = false;
      error = EmailInputError.empty;
    } else if (!valueRegExp.hasMatch(value)) {
      isValid = false;
      error = EmailInputError.invalid;
    } else {
      isValid = true;
      error = null;
    }
  }
}
