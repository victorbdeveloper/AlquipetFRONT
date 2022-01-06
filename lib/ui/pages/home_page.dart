import 'package:alquipet_front/providers/home_provider.dart';
import 'package:alquipet_front/ui/buttons/custom_outlined_button.dart';
import 'package:alquipet_front/ui/layouts/dashboard_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeProvider homeProvider = Get.find<HomeProvider>();

  @override
  void initState() {
    // homeProvider.testPeticion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: FutureBuilder<dynamic>(
        future: homeProvider.testPeticion(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: const <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Ha sucedido algo inesperado',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomOutlinedButton(
                          onPressed: () async {
                            await homeProvider.testPeticion();
                            setState(() {});
                          },
                          text: "Volver a intentar",
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return _HomePageContent(snapshot);
            } else {
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: const <Widget>[
                    Center(
                      child: Text(
                        'No hay datos que mostrar',
                      ),
                    )
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: <Widget>[
                  Center(
                    child: Text(
                      'State: ${snapshot.connectionState}',
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent(AsyncSnapshot<dynamic> snapshot, {Key? key})
      : super(key: key);

  @override
  __HomePageContentState createState() => __HomePageContentState();
}

class __HomePageContentState extends State<_HomePageContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green, child: Text("ASD"),);
  }
}

// Column(
//   children: <Widget>[
//     Center(
//       child: CustomOutlinedButton(
//           onPressed: () {
//             print("BOTÓN PETICIÓN PULSADO");
//             testPeticion();
//             // Get.toNamed("/second", parameters: {"a": "1", "b": "2"});
//           },
//           text: 'PETICIÓN'),
//     ),
//   ],
// ),
