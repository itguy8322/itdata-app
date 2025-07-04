// ignore_for_file: unnecessary_null_comparison

enum TextInputError { empty, invalid }

class TextInput {
  String value;
  TextInputError? error;
  bool? isValid;
  TextInput({required this.value, this.error, this.isValid});

  void validate() {
    if (value == '' || value == null) {
      isValid = false;
      error = TextInputError.empty;
    } else {
      isValid = true;
      error = null;
    }
  }
}
