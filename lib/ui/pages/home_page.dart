import 'package:alquipet_front/api/alquipet_api.dart';
import 'package:alquipet_front/providers/auth_provider.dart';
import 'package:alquipet_front/ui/buttons/custom_outlined_button.dart';
import 'package:alquipet_front/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        desktop: Column(
          children: [
            CustomOutlinedButton(
              onPressed: () {
                Get.toNamed("/login");
              },
              text: 'LOGIN',
            ),
            CustomOutlinedButton(
              onPressed: () {
                AuthProvider authProvider = Get.find<AuthProvider>();
                authProvider.logout();
              },
              text: 'LOGOUT',
            ),
          ],
        ),
        tablet: Column(
          children: <Widget>[
            CustomOutlinedButton(
              onPressed: () {
                Get.toNamed("/anuncio");
              },
              text: 'IR A ANUNCIO',
            ),
            CustomOutlinedButton(
              onPressed: () {
                Get.toNamed("/anuncios_favoritos");
              },
              text: 'IR A FAVORITOS',
            ),
            // _googleSignInAccount != null
            //     ? ListTile(
            //         leading: GoogleUserCircleAvatar(
            //           identity: _googleSignInAccount!,
            //         ),
            //         title: Text(_googleSignInAccount!.displayName ?? ''),
            //         subtitle: Text(_googleSignInAccount!.email),
            //       )
            //     : Container(),
          ],
        ),
        mobile: Column(
          children: <Widget>[
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
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// //TODO: CONVERTIR A STATELESS AL ACABAR LAS PRUEBAS!!
// class _HomePageState extends State<HomePage> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _googleSignInAccount;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Responsive(
//         desktop: Column(
//           children: [
//             CustomOutlinedButton(
//               onPressed: () {
//                 // print("_googleSignIn");
//                 // _handleSignIn(1);
//                 Get.toNamed("/login", parameters: {"a": "1", "b": "2"});
//               },
//               text: 'LOGIN',
//             ),
//             CustomOutlinedButton(
//               onPressed: () {
//                 AuthProvider authProvider = Get.find<AuthProvider>();
//                 authProvider.logout();
//                 // print("_googleSignIn");
//                 // _handleSignIn(1);
//                 // Get.toNamed("/login", parameters: {"a": "1", "b": "2"});
//               },
//               text: 'LOGOUT',
//             ),
//           ],
//         ),
//         tablet: Column(
//           children: <Widget>[
//             CustomOutlinedButton(
//               onPressed: () {
//                 Get.toNamed("/anuncio");
//               },
//               text: 'IR A ANUNCIO',
//             ),
//             CustomOutlinedButton(
//               onPressed: () {
//                 Get.toNamed("/anuncios_favoritos");
//               },
//               text: 'IR A FAVORITOS',
//             ),
//             // _googleSignInAccount != null
//             //     ? ListTile(
//             //         leading: GoogleUserCircleAvatar(
//             //           identity: _googleSignInAccount!,
//             //         ),
//             //         title: Text(_googleSignInAccount!.displayName ?? ''),
//             //         subtitle: Text(_googleSignInAccount!.email),
//             //       )
//             //     : Container(),
//           ],
//         ),
//         mobile: Column(
//           children: [
//             Center(
//               child: CustomOutlinedButton(
//                   onPressed: () {
//                     print("BOTÓN PETICIÓN PULSADO");
//                     testPeticion();
//                     // Get.toNamed("/second", parameters: {"a": "1", "b": "2"});
//                   },
//                   text: 'PETICIÓN'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   testPeticion() async {
//     ///DEFINIR QUERYPARAMS
//     final queryParameters = {'id': '61ac01f8ccec88e05fe6be23'};
//
//     ///DEFINIR BODY/DATA
//     final data = {'email': 'test01@test.com', 'password': '123456'};
//
//     ///REALIZAR PETICIÓN
//     try {
//       ///EJEMPLO PETICIÓN GET
//       // var response = await AlquipetApi.dioGet('/users/get_user',queryParams: queryParameters);
//       ///EJEMPLO PETICIÓN POST
//       var response = await AlquipetApi.dioPost('/auth/login_email',
//           queryParams: queryParameters, body: data);
//       print(response);
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
// }
