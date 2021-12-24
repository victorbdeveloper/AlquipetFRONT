import 'package:alquipet_front/services/local_storage.dart';
import 'package:alquipet_front/services/navigation_service.dart';
import 'package:alquipet_front/services/notifications_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await LocalStorage.configurePrefs();
  //TODO: DIO
  //TODO: router
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyApp(); //TODO: eliminar esta línea cuando se implemente GET
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
    //     ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
    //     ChangeNotifierProvider(create: (_) => CategoriesProvider()),
    //     ChangeNotifierProvider(create: (_) => UsersProvider()),
    //     ChangeNotifierProvider(create: (_) => UserFormProvider()),
    //   ],
    //   child: const MyApp(),
    // );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alquipet',
      home: const Home(),
      //TODO: BORRAR DESPUES!
      initialRoute: '/',
      // onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      // builder: (_, child) {
      //   final authProvider = Provider.of<AuthProvider>(context);
      //
      //   if (authProvider.authStatus == AuthStatus.checking) {
      //     return SplashLayout();
      //   }
      //
      //   if (authProvider.authStatus == AuthStatus.authenticated) {
      //     return DashboardLayout(child: child!);
      //   } else {
      //     return AuthLayout(child: child!);
      //   }
      // },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("HOLA MUNDO!"),
      ),
    );
  }
}
