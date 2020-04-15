String validateName(String value) {
  if (value.isEmpty) {
    return 'Name is required.';
  }
  final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
  if (!nameExp.hasMatch(value)) {
    return 'Please enter only alphabetical characters.';
  }
  return null;
}

String validateEmail(String value) {
  if (value.isEmpty) {
    return 'Email is required.';
  }
  final RegExp nameExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (!nameExp.hasMatch(value)) {
    return 'Please enter a valid email.';
  }
  return null;
}

String validateNumber(String value) {
  if (value.isEmpty) {
    return 'Mobile Number is required.';
  }
  final RegExp nameExp = new RegExp(r'^[0123456789 ]+$');
  if (!nameExp.hasMatch(value)) {
    return 'Please enter a valid mobile number.';
  }
  return null;
}
