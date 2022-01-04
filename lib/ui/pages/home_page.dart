import 'package:alquipet_front/ui/layouts/dashboard_layout.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: Text("HOME"),
    );
  }
}

// // @override
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     appBar: AppBar(
// //       centerTitle: true,
// //       title: const Text("ALQUIPET"),
// //       titleSpacing: 10.0,
// //     ),
// //     body: Row(
// //       children: <Widget>[
// //         Responsive.isMobile(context)
// //         Flexible(
// //           flex: 2,
// //           child: DrawerController(
// //             alignment: DrawerAlignment.start,
// //             child: Drawer(
// //               child: Column(
// //                 children: const <Widget>[
// //                   Text(
// //                     "AAAAAAA",
// //                   ),
// //                   Text("BBBBBBB"),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //         Flexible(
// //           flex: 8,
// //           child: Container(
// //             color: Colors.blue,
// //           ),
// //         )
// //       ],
// //     ),
// //     // Responsive(
// //     //   desktop:
// //     //
// //     // Column(
// //     //   children: [
// //     //     CustomOutlinedButton(
// //     //       onPressed: () {
// //     //         Get.toNamed("/login");
// //     //       },
// //     //       text: 'LOGIN',
// //     //     ),
// //     //     CustomOutlinedButton(
// //     //       onPressed: () {
// //     //         AuthProvider authProvider = Get.find<AuthProvider>();
// //     //         authProvider.logout();
// //     //       },
// //     //       text: 'LOGOUT',
// //     //     ),
// //     //   ],
// //     // ),
// //     // tablet: Column(
// //     //   children: <Widget>[
// //     //     CustomOutlinedButton(
// //     //       onPressed: () {
// //     //         Get.toNamed("/anuncio");
// //     //       },
// //     //       text: 'IR A ANUNCIO',
// //     //     ),
// //     //     CustomOutlinedButton(
// //     //       onPressed: () {
// //     //         Get.toNamed("/anuncios_favoritos");
// //     //       },
// //     //       text: 'IR A FAVORITOS',
// //     //     ),
// //     //     // _googleSignInAccount != null
// //     //     //     ? ListTile(
// //     //     //         leading: GoogleUserCircleAvatar(
// //     //     //           identity: _googleSignInAccount!,
// //     //     //         ),
// //     //     //         title: Text(_googleSignInAccount!.displayName ?? ''),
// //     //     //         subtitle: Text(_googleSignInAccount!.email),
// //     //     //       )
// //     //     //     : Container(),
// //     //   ],
// //     // ),
// //     // mobile: Column(
// //     //   children: <Widget>[
// //     //     Center(
// //     //       child: CustomOutlinedButton(
// //     //           onPressed: () {
// //     //             print("BOTÓN PETICIÓN PULSADO");
// //     //             testPeticion();
// //     //             // Get.toNamed("/second", parameters: {"a": "1", "b": "2"});
// //     //           },
// //     //           text: 'PETICIÓN'),
// //     //     ),
// //     //   ],
// //     // ),
// //     // ),
// //   );
// // }
// //
// // testPeticion() async {
// //   ///DEFINIR QUERYPARAMS
// //   final queryParameters = {'id': '61ac01f8ccec88e05fe6be23'};
// //
// //   ///DEFINIR BODY/DATA
// //   final data = {'email': 'test01@test.com', 'password': '123456'};
// //
// //   ///REALIZAR PETICIÓN
// //   try {
// //     ///EJEMPLO PETICIÓN GET
// //     // var response = await AlquipetApi.dioGet('/users/get_user',queryParams: queryParameters);
// //     ///EJEMPLO PETICIÓN POST
// //     var response = await AlquipetApi.dioPost('/auth/login_email',
// //         queryParams: queryParameters, body: data);
// //     print(response);
// //   } catch (e) {
// //     print("Error: $e");
// //   }
// // }
// }
