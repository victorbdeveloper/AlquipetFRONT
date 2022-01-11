import 'package:alquipet_front/providers/favorited_listings_provider.dart';
import 'package:alquipet_front/providers/home_provider.dart';
import 'package:alquipet_front/providers/listings_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../responsive.dart';

class ListingsUserPaginatedControl extends StatelessWidget {
  const ListingsUserPaginatedControl({
    required this.onPressedBack,
    required this.onPressedForward,
    Key? key,
  }) : super(key: key);

  final Function onPressedBack;
  final Function onPressedForward;

  @override
  Widget build(BuildContext context) {
    ListingsUserProvider listingsUserProvider =
        Get.find<ListingsUserProvider>();

    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () => onPressedBack(),
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: Responsive.isDesktop(context)
              ? 30.0
              : Responsive.isTablet(context)
                  ? 25.0
                  : 20,
          color: Colors.blue,
          disabledColor: Colors.grey,
        ),
        Text(" Pg:    1    / 5 "),
        IconButton(
          onPressed: () => onPressedBack(),
          icon: const Icon(Icons.arrow_forward_ios),
          iconSize: Responsive.isDesktop(context)
              ? 30.0
              : Responsive.isTablet(context)
                  ? 25.0
                  : 20,
          color: Colors.blue,
          disabledColor: Colors.grey,
        ),
        Text(" Resultados por pg: 10 "),
        // NumberPicker(
        //   value: hom,
        //   minValue: null,
        //   onChanged: (int value) {},
        //   maxValue: null,
        // ),
        Flexible(
          child: Container(),
        ),
        if (Responsive.isDesktop(context))
          ToggleSwitch(
            minWidth: 70.0,
            initialLabelIndex: listingsUserProvider.isListTypeSelected ? 0 : 1,
            cornerRadius: 5.0,
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            icons: const [Icons.list, Icons.apps],
            iconSize: 150.0,
            activeBgColors: const [
              [Colors.blue],
              [Colors.blue],
            ],
            onToggle: (index) {
              listingsUserProvider.changeIsListTypeSelected();
              print('switched to: $index');
            },
          ),
      ],
    );
  }
}
