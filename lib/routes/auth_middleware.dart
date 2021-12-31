import 'package:alquipet_front/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final authProvider = Get.find<AuthProvider>();


  @override
  RouteSettings? redirect(String? route) {
    return authProvider.authStatus == AuthStatus.authenticated
        ? null
        : const RouteSettings(name: '/inicio');
  }
}
