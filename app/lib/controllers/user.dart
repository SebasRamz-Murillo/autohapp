import 'package:app/models/user.dart';

class UserController {
  User? user;
  bool get isLogged => user != null;

  bool login(String username, String password) {
    if (username == "admin" && password == "admin") {
      user = User(email: username, password: password);
      return true;
    }

    return false;
  }

  void logout() {
    user = null;
  }

  String generarCodigo() {
    //Logica para obtener un codigo desde la api
    return "1234";
  }

  void validarCodigo() {
    //Logica para validar el codigo
  }
}
