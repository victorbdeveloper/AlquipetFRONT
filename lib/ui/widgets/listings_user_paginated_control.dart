import 'package:alquipet_front/providers/listings_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../responsive.dart';

class ListingsUserPaginatedControl extends StatelessWidget {
  const ListingsUserPaginatedControl({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListingsUserProvider listingsUserProvider =
        Get.find<ListingsUserProvider>();

    return GetBuilder<ListingsUserProvider>(
        init: ListingsUserProvider(),
        id: "listingsUserPageContent",
        builder: (controller) {
          return Row(
            children: <Widget>[
              const SizedBox(
                width: 10.0,
              ),
              const Text("Pg: "),
              IconButton(
                onPressed: () => {
                  if (listingsUserProvider.currentPage != 1)
                    {
                      listingsUserProvider.currentPage =
                          listingsUserProvider.currentPage - 1,
                      listingsUserProvider.indexFrom =
                          listingsUserProvider.indexFrom -
                              listingsUserProvider.numberResultsShowed,
                      listingsUserProvider.indexLimit =
                          listingsUserProvider.numberResultsShowed,
                      listingsUserProvider.isLoading = true,
                      listingsUserProvider
                          .update(<String>["listingsUserPageContent"]),
                      listingsUserProvider.getFilteredPaginatedListings(),
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
              Text(listingsUserProvider.currentPage.toString()),
              const SizedBox(
                width: 10.0,
              ),
              const Text("/"),
              const SizedBox(
                width: 10.0,
              ),
              Text(listingsUserProvider.totalPages.toString()),
              IconButton(
                onPressed: () => {
                  if (listingsUserProvider.currentPage !=
                      listingsUserProvider.totalPages)
                    {
                      listingsUserProvider.currentPage =
                          listingsUserProvider.currentPage + 1,
                      listingsUserProvider.indexFrom =
                          listingsUserProvider.indexFrom +
                              listingsUserProvider.numberResultsShowed,
                      listingsUserProvider.indexLimit =
                          listingsUserProvider.numberResultsShowed,
                      listingsUserProvider.isLoading = true,
                      listingsUserProvider
                          .update(<String>["listingsUserPageContent"]),
                      listingsUserProvider.getFilteredPaginatedListings(),
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
                  value: listingsUserProvider.numberResultsShowed,
                  items: <int>[10, 20, 50].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    listingsUserProvider.numberResultsShowed = newVal!;
                    listingsUserProvider.indexFrom = 1;
                    listingsUserProvider.currentPage = 1;
                    listingsUserProvider.indexLimit =
                        listingsUserProvider.numberResultsShowed;
                    listingsUserProvider.isLoading = true;
                    listingsUserProvider
                        .update(<String>["listingsUserPageContent"]);
                    listingsUserProvider.getFilteredPaginatedListings();
                  }),
              Flexible(
                child: Container(),
              ),
              if (Responsive.isDesktop(context))
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ToggleSwitch(
                    minWidth: 70.0,
                    initialLabelIndex:
                        listingsUserProvider.isListTypeSelected ? 0 : 1,
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
                    },
                  ),
                ),
            ],
          );
        });
  }
}
