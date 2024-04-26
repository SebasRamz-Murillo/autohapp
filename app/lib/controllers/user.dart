import 'dart:convert';
import 'dart:io';
import 'package:app/models/user.dart';
import 'package:http/http.dart' as http;

class UserController {
  User? user;
  bool get isLogged => user != null;
  String url = "http://192.10.0.2/api/";
//192.10.0.1
  Future<bool> login(String username, String password) async {
    String _path = "${url}login";
    print(_path);
    /*hectorflores_rdz@outlook.com
    4789108Flores
    */
    try {
      http.Response res = await http.post(Uri.parse(_path),
          body: jsonEncode({
            "email": username,
            "password": password,
          }));

      print(res);

      if (res.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(res.body);
        if (responseBody.containsKey("token")) {
          user = User(email: username, password: password, token: responseBody["token"]);
          return true;
        } else {
          print("Token not found in response body");
          return false;
        }
      } else {
        print("Unexpected status code: ${res.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error during login request: $e");
      return false;
    }
  }

  Future<void> logout() async {
    String _path = "${url}exit";
    try {
      //Logica para cerrar sesion
      http.Response res = await http.get(Uri.parse(_path));
      if (res.statusCode == 200) {
        print("Logout successful");
        user!.clear();
      }
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  Future<int> validarCodigo(int codigo) async {
    String _path = "${url}verificarCodigo";
    //Logica para validar el codigo
    http.Response res = await http.post(Uri.parse(_path), body: {
      "codigo": codigo,
    });

    if (res.statusCode == 200) {
      print("Codigo validado correctamente");
      Map<String, dynamic> responseBody = jsonDecode(res.body);
      if (responseBody.containsKey("codigoMovil")) {
        return responseBody["codigoMovil"];
      }
    } else {
      print("Error al validar el codigo");
      return 0;
    }
    return 0;
  }
}
