class DadosLogin {

  static final DadosLogin _instance = DadosLogin._internal();

  // passes the instantiation to the _instance object
  factory DadosLogin() => _instance;

  //initialize variables in here
  DadosLogin._internal() {
    _userLogin = "";
  }
   String _userLogin;

  //short getter for my variable
  String get userLogin => _userLogin;

  //short setter for my variable
  set userLogin(String value) => userLogin = value;

}