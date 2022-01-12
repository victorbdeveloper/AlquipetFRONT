import 'package:alquipet_front/providers/favorited_listings_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../responsive.dart';

class FavoritedListingsPaginatedControl extends StatelessWidget {
  const FavoritedListingsPaginatedControl({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoritedListingsProvider favoritedListingsProvider =
        Get.find<FavoritedListingsProvider>();

    return GetBuilder<FavoritedListingsProvider>(
        init: FavoritedListingsProvider(),
        id: "favoritedListingsPageContent",
        builder: (controller) {
          return Row(
            children: <Widget>[
              const SizedBox(
                width: 10.0,
              ),
              const Text("Pg: "),
              IconButton(
                onPressed: () => {
                  if (favoritedListingsProvider.currentPage != 1)
                    {
                      favoritedListingsProvider.currentPage =
                          favoritedListingsProvider.currentPage - 1,
                      favoritedListingsProvider.indexFrom =
                          favoritedListingsProvider.indexFrom -
                              favoritedListingsProvider.numberResultsShowed,
                      favoritedListingsProvider.indexLimit =
                          favoritedListingsProvider.numberResultsShowed,
                      favoritedListingsProvider.isLoading = true,
                      favoritedListingsProvider
                          .update(<String>["favoritedListingsPageContent"]),
                      favoritedListingsProvider.getFilteredPaginatedListings(),
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
              Text(favoritedListingsProvider.currentPage.toString()),
              const SizedBox(
                width: 10.0,
              ),
              const Text("/"),
              const SizedBox(
                width: 10.0,
              ),
              Text(favoritedListingsProvider.totalPages.toString()),
              IconButton(
                onPressed: () => {
                  if (favoritedListingsProvider.currentPage !=
                      favoritedListingsProvider.totalPages)
                    {
                      favoritedListingsProvider.currentPage =
                          favoritedListingsProvider.currentPage + 1,
                      favoritedListingsProvider.indexFrom =
                          favoritedListingsProvider.indexFrom +
                              favoritedListingsProvider.numberResultsShowed,
                      favoritedListingsProvider.indexLimit =
                          favoritedListingsProvider.numberResultsShowed,
                      favoritedListingsProvider.isLoading = true,
                      favoritedListingsProvider
                          .update(<String>["favoritedListingsPageContent"]),
                      favoritedListingsProvider.getFilteredPaginatedListings(),
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
                  value: favoritedListingsProvider.numberResultsShowed,
                  items: <int>[10, 20, 50].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    favoritedListingsProvider.numberResultsShowed = newVal!;
                    favoritedListingsProvider.indexFrom = 1;
                    favoritedListingsProvider.currentPage = 1;
                    favoritedListingsProvider.indexLimit =
                        favoritedListingsProvider.numberResultsShowed;
                    favoritedListingsProvider.isLoading = true;
                    favoritedListingsProvider
                        .update(<String>["favoritedListingsPageContent"]);
                    favoritedListingsProvider.getFilteredPaginatedListings();
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
                        favoritedListingsProvider.isListTypeSelected ? 0 : 1,
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
                      favoritedListingsProvider.changeIsListTypeSelected();
                    },
                  ),
                ),
            ],
          );
        });
  }
}
