import 'package:app/controllers/user.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCode = TextEditingController();
  bool _codigoValido = false;
  UserController _userController = UserController();
  String _codigo = "";
  void validar() {
    if (_controllerCode.text == "1234") {
      _codigoValido = true;
      return;
    }
    SnackBar snackBar = const SnackBar(
      backgroundColor: Colors.red,
      content: Text("Código incorrecto"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _obtenerCodigo() {
    _codigo = _userController.generarCodigo();

    if (_codigo == "") {
      SnackBar snackBar = const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Error al obtener el código"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppSegura"),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "HOLA!",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            if (!_codigoValido) _ValidarCodigo(),
            if (_codigoValido) _GeneraCodigo(),
          ],
        ),
      ),
    );
  }

  Widget _GeneraCodigo() {
    _obtenerCodigo();
    return Column(
      children: [
        Text(
          "Tu código de acceso es: $_codigo",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 30),
        TextButton(
          onPressed: () {
            setState(() {
              _codigoValido = false;
            });
          },
          child: const Text("Generar nuevo código"),
        ),
      ],
    );
  }

  Widget _ValidarCodigo() {
    return Column(
      children: [
        Text(
          "Inserta tu código de acceso",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            controller: _controllerCode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Código",
              prefixIcon: const Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextButton(
            onPressed: () {
              setState(() {
                validar();
              });
            },
            child: const Text("Validar"))
      ],
    );
  }
}
