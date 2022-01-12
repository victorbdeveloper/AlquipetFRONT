import "package:alquipet_front/api/alquipet_api.dart";
import "package:alquipet_front/models/http/auth_response.dart";
import "package:alquipet_front/models/user.dart";
import "package:alquipet_front/providers/side_menu_provider.dart";
import "package:alquipet_front/services/local_storage.dart";
import "package:alquipet_front/services/notifications_service.dart";
import "package:get/get.dart";
import "package:google_sign_in/google_sign_in.dart";

enum AuthStatus { checking, authenticated, notAuthenticated }
enum AuthType { notYet, email, google }

class AuthProvider extends GetxController {
  AuthStatus authStatus = AuthStatus.checking;
  AuthType authType = AuthType.notYet;
  User? user;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _googleSignInAccount;

  // AuthProvider() {
  //   isAuthenticated();
  // }
  //
  // /// COMPRUEBA SI EL USUARIO ESTA AUTENTICADO
  // Future<bool> isAuthenticated() async {
  //   final token = LocalStorage.prefs.getString("token");
  //
  //   if (token == null) {
  //     authStatus = AuthStatus.notAuthenticated;
  //     authType = AuthType.notYet;
  //     // notifyListeners();
  //     return false;
  //   }
  //
  //   try {
  //     if (authType == AuthType.google) {
  //       handleSignIn();
  //     }
  //
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     authStatus = AuthStatus.notAuthenticated;
  //     authType = AuthType.notYet;
  //     // notifyListeners();
  //     return false;
  //   }
  // }

  ///CREAR NUEVO USUARIO
  Future<String?> createUser(Map<String, String> data) async {
    try {
      ///REALIZA LA PETICIÓN AL SERVIDOR
      final authResponse = AuthResponse.fromMap(
        await AlquipetApi.dioPost("/users/create_user", body: data),
      );
      // print("AUTHRESPONSE cU: ${authResponse.toString()}");

    } catch (error) {
      authStatus = AuthStatus.notAuthenticated;
      authType = AuthType.notYet;
      print(error.toString());
      return ("Email / Nick no válidos");
    }
    return null;
  }

  /// LOGIN EMAIL
  Future<String?> loginEmail(Map<String, String> data) async {
    // print("DATA: ${data.toString()}");

    try {
      ///REALIZA LA PETICIÓN AL SERVIDOR
      final authResponse = AuthResponse.fromMap(
        await AlquipetApi.dioPost("/auth/login_email", body: data),
      );
      // print("AUTHRESPONSE lE: ${authResponse.toString()}");

      ///ACTUALIZA LAS VARIABLES
      user = authResponse.user;
      authStatus = AuthStatus.authenticated;
      authType = AuthType.email;

      ///GUARDA EN EL LOCALSTORAGE EL TOKEN RECIBIDO
      LocalStorage.prefs.setString("token", authResponse.token!);

      ///ACTUALIZA LA CONFIGURACIÓN DE DIO CON EL NUEVO TOKEN
      AlquipetApi.configureDio();

      ///MUESTRA MENSAJE
      NotificationsService.showSnackBar("Login correcto. Bienvenido!");
    } catch (error) {
      authStatus = AuthStatus.notAuthenticated;
      authType = AuthType.notYet;
      print("ERROR: ${error.toString()}");
      return "Email / Contraseña no válidos";
    }
    return null;
  }

  ///LOGIN GOOGLE
  Future<String?> handleSignIn() async {
    try {
      ///INTENTA INICIAR SESIÓN CON GOOGLE SOLO SI NO ESTA INICIADA YA LA SESIÓN
      _googleSignInAccount = await _googleSignIn.signIn();
      // print("CURRENT USER: ${_googleSignIn.currentUser}");

      ///OBTIENE LA AUTENTICACIÓN DEL USUARIO
      GoogleSignInAuthentication _googleSignInAuthentication =
          await _googleSignInAccount!.authentication;

      ///REALIZA LA PETICIÓN AL SERVIDOR
      final authResponse = AuthResponse.fromMap(
        await AlquipetApi.dioPost("/auth/login_google",
            body: {"id_token": _googleSignInAuthentication.idToken}),
      );
      // print("AUTHRESPONSE hSI: $authResponse");

      ///ACTUALIZA LAS VARIABLES
      user = authResponse.user;
      authStatus = AuthStatus.authenticated;
      authType = AuthType.google;

      ///GUARDA EN EL LOCALSTORAGE EL TOKEN RECIBIDO
      LocalStorage.prefs.setString("token", authResponse.token!);

      ///ACTUALIZA LA CONFIGURACIÓN DE DIO CON EL NUEVO TOKEN
      AlquipetApi.configureDio();

      ///MUESTRA MENSAJE
      NotificationsService.showSnackBar("Login correcto. Bienvenido!");
    } catch (error) {
      authStatus = AuthStatus.notAuthenticated;
      authType = AuthType.notYet;
      print(error.toString());
      return "No se ha podido iniciar sesión en Google";
    }

    return null;
  }

  ///LOGOUT
  Future<void> logout() async {
    if (authType == AuthType.google) {
      try {
        ///CIERRA LA SESIÓN DE GOOGLE DEL USUARIO
        _googleSignInAccount = await _googleSignIn.disconnect();
        // print("CURRENT USER ${_googleSignIn.currentUser}");
      } catch (error) {
        print(error.toString());
      }
    }

    ///ELIMINA EL TOKEN DEL LOCAL STORAGE Y EL USUARIO DEL SISTEMA
    LocalStorage.prefs.remove("token");
    user = null;

    ///ACTUALIZA LAS VARIABLES
    authStatus = AuthStatus.notAuthenticated;
    authType = AuthType.notYet;

    ///NOTIFICA A LOS PROVIDERS CORRESPONDIENTES
    final SideMenuProvider sideMenuProvider = Get.find<SideMenuProvider>();
    sideMenuProvider.update();
    update();

    ///MUESTRA MENSAJE
    NotificationsService.showSnackBarLogout("Sesión cerrada con éxito");

    ///REDIRIGE A INICIO Y BORRA EL HISTORIAL DE RUTAS
    Get.offAllNamed("/");
  }
}
