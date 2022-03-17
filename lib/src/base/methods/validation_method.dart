import '../constants/strings_constant.dart';

String? validateEmail(String? email) {
  if (email!.isEmpty) {
    return (emptyEmail);
  }
  if (!RegExp(regexEmail)
      .hasMatch(email)) {
    return (checkEmail);
  }
  return null;
}

String? validatePassword(String? password) {
  RegExp regex = RegExp(regexPassword);
  if (password!.isEmpty) {
    return (emptyPassword);
  }
  if (!regex.hasMatch(password)) {
    return (checkPassword);
  }
  return null;
}

String? validateUserName(String? user) {
  RegExp regex = RegExp(regexUserName);
  if (user!.isEmpty) {
    return (emptyPassword);
  }
  if (!regex.hasMatch(user)) {
    return (checkUserName);
  }
  return null;
}
String? validateMobile(String? mobile) {
  if (mobile!.isEmpty) {
    return (emptyMobile);
  }
  if(mobile.length < 10){
    return ('Only 10 numbers allowed');
  }
  return null;
}