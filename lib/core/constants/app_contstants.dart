
// You can also just let this float around in the file without encapsulating
// in a class. Then you'll have to make sure that system wide you don't have
// duplicate variable names.
class RoutePaths {
  static const String Login = 'login';
  static const String Home = '/';
  static const String Post = 'post';
}

final bool devMode = false;
final String username = "username";
final String isremember = "is_remember";
final String emptyEmailField = "Email field cannot be empty!";
final String emptyTextField = "Field cannot be empty!";
final String emptyPasswordField = "Password field cannot be empty";
final String invalidEmailField =
    "Email provided isn\'t valid.Try another email address";
final String passwordLengthError = "Password length must be greater than 6";
final String emptyUsernameField = "Username  cannot be empty";
final String usernameLengthError = "Username length must be greater than 6";
final String emailRegex = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
    "\\@" +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
    "(" +
    "\\." +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
    ")+";

