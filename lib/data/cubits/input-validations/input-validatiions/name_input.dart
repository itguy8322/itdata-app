// ignore_for_file: unnecessary_null_comparison

enum NameInputError { empty, invalid }

class NameInput {
  String value;
  NameInputError? error;
  bool? isValid;
  NameInput({required this.value, this.error, this.isValid});

  void validate() {
    final RegExp nameRegExp = RegExp(r"^[a-zA-Z ]+$");

    if (value == '' || value == null) {
      isValid = false;
      error = NameInputError.empty;
    } else if (!nameRegExp.hasMatch(value)) {
      isValid = false;
      error = NameInputError.invalid;
    } else {
      isValid = true;
      error = null;
    }
  }
}
