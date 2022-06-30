class ValidationUtil {
  static final emailRegExp = RegExp("^[a-zA-Z0-9_+&*-]+(?:\\."
      "[a-zA-Z0-9_+&*-]+)*@"
      "(?:[a-zA-Z0-9-]+\\.)+[a-z"
      "A-Z]{2,50}\$");

  static final passwordRegExp = RegExp("^" // start regexp
      "(?=.*\\d)"        //at least 1 digit
      "(?=.*[a-z])"      //at least 1 lower case letter
      "(?=.*[A-Z])"      //at least 1 upper case letter
      "(?=.*\\W)"        //at least 1 non word character
      "(?=\\S+\$)"       //no white spaces
      ".{8,}"            //at least 8 characters
      "\$");             // end regexp

  static String? validateEmail(String? email) {
    if (email?.isEmpty ?? true) {
      return "Email must not be empty";
    }
    if (!emailRegExp.hasMatch(email ?? "")) {
      return "Email formatting error";
    }

    return null;
  }

  static String? validatePassword(String? pass) {
    if (!passwordRegExp.hasMatch(pass ?? "")) {
      return "Password must ne at least 8 character length, must contain at least 1 uppercase, 1 lowercase, 1 digit and 1 special character";
    }
    return null;
  }
}