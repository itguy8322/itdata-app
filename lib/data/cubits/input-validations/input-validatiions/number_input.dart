// ignore_for_file: unnecessary_null_comparison

enum NumberInputError { empty, invalid }

class NumberInput {
  String value;
  NumberInputError? error;
  bool? isValid;
  NumberInput({required this.value, this.error, this.isValid});

  void validate() {
    final RegExp numberRegExp = RegExp(r'^[0-9]+$');

    if (value == '' || value == null) {
      isValid = false;
      error = NumberInputError.empty;
    } else if (!numberRegExp.hasMatch(value)) {
      isValid = false;
      error = NumberInputError.invalid;
    } else {
      isValid = true;
      error = null;
    }
  }
}
