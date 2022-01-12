import "package:alquipet_front/providers/auth_provider.dart";
import "package:alquipet_front/validators/login_validators.dart";
import "package:flutter/material.dart";
import "package:flutter_login/flutter_login.dart";
import "package:flutter_signin_button/button_list.dart";
import "package:get/get.dart";

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final AuthProvider authProvider = Get.find<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "ALQUIPET",
      scrollable: true,

      // logo: const AssetImage("assets/images/ecorp-lightblue.png"),
      hideForgotPasswordButton: true,
      messages: LoginMessages(
        additionalSignUpFormDescription:
            "Por favor, complete este formulario para finalizar el registro",
        confirmPasswordError: "Las contraseñas no son iguales",
        passwordHint: "Contraseña",
        confirmPasswordHint: "Repita la contraseña",
        confirmSignupButton: "CREAR CUENTA",
        confirmSignupSuccess: "Cuenta creada con éxito",
        goBackButton: "VOLVER",
        loginButton: "LOGIN",
        providersTitleFirst: "o accede mediante",
        providersTitleSecond: "o",
        signupButton: "CREAR CUENTA",
        signUpSuccess: "Cuenta creada con éxito",
        additionalSignUpSubmitButton: "ACEPTAR",
        flushbarTitleSuccess: "CONFIRMADO",
      ),
      onLogin: (p0) {
        return authProvider.loginEmail({
          "email": p0.name,
          "password": p0.password,
        });
      },
      loginAfterSignUp: false,
      onSignup: (p0) {
        Map<String, String> data = {
          "user_name": p0.additionalSignupData!["nick"]!,
          "name": p0.additionalSignupData!["name"]!,
          "last_name": p0.additionalSignupData!["lastName"]!,
          "email": p0.name!,
          "password": p0.password!,
          "phone": p0.additionalSignupData!["phone"]!,
        };
        // print("DATOS: $data");
        return authProvider.createUser(data);
      },
      additionalSignupFields: const <UserFormField>[
        UserFormField(
          fieldValidator: LoginValidators.fieldEmptyValidator,
          keyName: "nick",
          displayName: "Nick usuario",
          icon: Icon(Icons.animation),
          userType: LoginUserType.name,
        ),
        UserFormField(
          keyName: "name",
          fieldValidator: LoginValidators.fieldEmptyValidator,
          displayName: "Nombre",
          icon: Icon(Icons.account_circle),
          userType: LoginUserType.name,
        ),
        UserFormField(
          keyName: "lastName",
          fieldValidator: LoginValidators.fieldEmptyValidator,
          displayName: "Apellidos",
          icon: Icon(Icons.account_circle),
          userType: LoginUserType.name,
        ),
        UserFormField(
          keyName: "phone",
          fieldValidator: LoginValidators.phoneValidator,
          displayName: "Teléfono",
          icon: Icon(Icons.phone),
          userType: LoginUserType.phone,
        ),
      ],
      loginProviders: <LoginProvider>[
        LoginProvider(
          button: Buttons.GoogleDark,
          label: "Google",
          callback: () {
            return authProvider.handleSignIn();
          },
        ),
      ],
      disableCustomPageTransformer: true,
      onSubmitAnimationCompleted: () {
        Get.offNamed("/");
      },

      onRecoverPassword: (_) {},
    );
  }
}
