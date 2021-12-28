import 'package:alquipet_front/api/alquipet_api.dart';
import 'package:alquipet_front/ui/buttons/custom_outlined_button.dart';
import 'package:alquipet_front/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//TODO: CONVERTIR A STATELESS AL ACABAR LAS PRUEBAS!!
class _HomePageState extends State<HomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _googleSignInAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        desktop: const Center(
          child: Text('DESKTOP'),
        ),
        tablet: Column(
          children: <Widget>[
            CustomOutlinedButton(
              onPressed: () {
                print("_googleSignIn");
                _handleSignIn(1);
                // Get.toNamed("/second", parameters: {"a": "1", "b": "2"});
              },
              text: '_googleSignIn',
            ),
            _googleSignInAccount != null
                ? ListTile(
                    leading: GoogleUserCircleAvatar(
                      identity: _googleSignInAccount!,
                    ),
                    title: Text(_googleSignInAccount!.displayName ?? ''),
                    subtitle: Text(_googleSignInAccount!.email),
                  )
                : Container(),
            CustomOutlinedButton(
              onPressed: () {
                print("_googleDisconnect");
                _handleSignIn(2);
                // Get.toNamed("/second", parameters: {"a": "1", "b": "2"});
              },
              text: '_googleDisconnect',
            ),
          ],
        ),
        mobile: Column(
          children: [
            Center(
              child: CustomOutlinedButton(
                  onPressed: () {
                    print("BOTÓN PETICIÓN PULSADO");
                    testPeticion();
                    // Get.toNamed("/second", parameters: {"a": "1", "b": "2"});
                  },
                  text: 'PETICIÓN'),
            ),
          ],
        ),
      ),
    );
  }

  testPeticion() async {
    ///DEFINIR QUERYPARAMS
    final queryParameters = {'id': '61ac01f8ccec88e05fe6be23'};

    ///DEFINIR BODY/DATA
    final data = {'email': 'test01@test.com', 'password': '123456'};

    ///REALIZAR PETICIÓN
    try {
      ///EJEMPLO PETICIÓN GET
      // var response = await AlquipetApi.dioGet('/users/get_user',queryParams: queryParameters);
      ///EJEMPLO PETICIÓN POST
      var response = await AlquipetApi.dioPost('/auth/login_email',
          queryParams: queryParameters, body: data);
      print(response);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _handleSignIn(int x) async {
    // GoogleSignIn _googleSignIn = GoogleSignIn();
    // GoogleSignInAccount? _googleSignInAccount;

    if (x == 1) {
      try {
        //TODO: HACER VALIDACIONES DE POSIBLES RESPONSES ERRONEAS
        ///INTENTA INICIAR SESIÓN CON GOOGLE SOLO SI NO ESTA INICIADA YA LA SESIÓN
        _googleSignInAccount = await _googleSignIn.signIn();
        print("CURRENT USER ${_googleSignIn.currentUser}");

        ///OBTIENE LA AUTENTICACIÓN DEL USUARIO
        GoogleSignInAuthentication _googleSignInAuthentication =
            await _googleSignInAccount!.authentication;

        //TODO: ESTE ID ES EL QUE HAY QUE PASAR AL SERVICIO REST
        print("ID: ${_googleSignInAuthentication.idToken}");
        setState(() {});
      } catch (error) {
        print(error);
      }
    } else if (x == 2) {
      try {
        ///CIERRA LA SESIÓN DEL USUARIO
        _googleSignInAccount = await _googleSignIn.disconnect();
        print("CURRENT USER ${_googleSignIn.currentUser}");
        setState(() {});
      } catch (error) {
        print(error);
      }
    }
  }
}
