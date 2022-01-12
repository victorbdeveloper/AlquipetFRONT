import 'package:alquipet_front/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../responsive.dart';

class HomePaginatedControl extends StatelessWidget {
  const HomePaginatedControl({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Get.find<HomeProvider>();

    return GetBuilder<HomeProvider>(
        init: HomeProvider(),
        id: "homePageContent",
        builder: (controller) {
          return Row(
            children: <Widget>[
              const SizedBox(
                width: 10.0,
              ),
              const Text("Pg: "),
              IconButton(
                onPressed: () => {
                  if (homeProvider.currentPage != 1)
                    {
                      homeProvider.currentPage = homeProvider.currentPage - 1,
                      homeProvider.indexFrom = homeProvider.indexFrom -
                          homeProvider.numberResultsShowed,
                      homeProvider.indexLimit =
                          homeProvider.numberResultsShowed,
                      homeProvider.isLoading = true,
                      homeProvider.update(<String>["homePageContent"]),
                      homeProvider.getFilteredPaginatedListings(),
                    }
                },
                // constraints: const BoxConstraints(maxWidth: 20),
                // padding: EdgeInsets.zero,
                // visualDensity: const VisualDensity(horizontal: -4),
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: Responsive.isDesktop(context)
                    ? 25.0
                    : Responsive.isTablet(context)
                        ? 20.0
                        : 15,
                color: Colors.blue,
                disabledColor: Colors.grey,
              ),
              Text(homeProvider.currentPage.toString()),
              const SizedBox(
                width: 10.0,
              ),
              const Text("/"),
              const SizedBox(
                width: 10.0,
              ),
              Text(homeProvider.totalPages.toString()),
              IconButton(
                onPressed: () => {
                  if (homeProvider.currentPage != homeProvider.totalPages)
                    {
                      homeProvider.currentPage = homeProvider.currentPage + 1,
                      homeProvider.indexFrom = homeProvider.indexFrom +
                          homeProvider.numberResultsShowed,
                      homeProvider.indexLimit =
                          homeProvider.numberResultsShowed,
                      homeProvider.isLoading = true,
                      homeProvider.update(<String>["homePageContent"]),
                      homeProvider.getFilteredPaginatedListings(),
                    }
                },
                // constraints: const BoxConstraints(maxWidth: 20),
                // padding: EdgeInsets.zero,
                // visualDensity: const VisualDensity(horizontal: -4),
                icon: const Icon(Icons.arrow_forward_ios),
                iconSize: Responsive.isDesktop(context)
                    ? 25.0
                    : Responsive.isTablet(context)
                        ? 20.0
                        : 15,
                color: Colors.blue,
                disabledColor: Colors.grey,
              ),
              const Text(" Mostrar: "),
              DropdownButton<int>(
                  hint: const Text("Pick"),
                  value: homeProvider.numberResultsShowed,
                  items: <int>[10, 20, 50].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    homeProvider.numberResultsShowed = newVal!;
                    homeProvider.indexFrom = 1;
                    homeProvider.currentPage = 1;
                    homeProvider.indexLimit = homeProvider.numberResultsShowed;
                    homeProvider.isLoading = true;
                    homeProvider.update(<String>["homePageContent"]);
                    homeProvider.getFilteredPaginatedListings();
                  }),
              Flexible(
                child: Container(),
              ),
              if (Responsive.isDesktop(context))
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ToggleSwitch(
                    minWidth: 70.0,
                    initialLabelIndex: homeProvider.isListTypeSelected ? 0 : 1,
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
                      homeProvider.changeIsListTypeSelected();
                    },
                  ),
                ),
            ],
          );
        });
  }
}
