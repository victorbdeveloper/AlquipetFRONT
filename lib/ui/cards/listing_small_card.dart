import 'dart:ui';

import 'package:alquipet_front/helpers/date_helper.dart';
import 'package:alquipet_front/models/listing.dart';
import "package:flutter/material.dart";

class ListingSmallCard extends StatelessWidget {
  final Listing listing;

  const ListingSmallCard({
    Key? key,
    required this.listing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = (listing.photos!.isEmpty)
        ? const Image(
            image: AssetImage('no-image.jpg'),
            width: 150,
            height: 150,
            fit: BoxFit.fill,
          )
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif',
            image: listing.photos!.first.urlCloudinary!,
            width: 150,
            height: 150,
            fit: BoxFit.fill,
          );

//TODO: PENDIENTE DE IMPLEMENTAR FAVORITOS!!
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: image,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "Fecha: ",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: DateHelper.getDateShortFormatWithBars(
                          listing.datePublication),
                      style: const TextStyle(
                        color: Color(0xff092044),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "Provincia: ",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: listing.address!.province,
                      style: const TextStyle(
                        color: Color(0xff092044),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                '${listing.price.toString()}€',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    // color: Colors.red,
                    color: Color(0xff092044),
                    fontWeight: FontWeight.w900,
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic),
              ),
              // if (authProvider.authStatus == AuthStatus.authenticated)
              //   const SizedBox(
              //     width: 30,
              //   ),
              // if (authProvider.authStatus == AuthStatus.authenticated)
              //   Align(
              //     alignment: Alignment.topRight,
              //     child: Container(
              //       color: Colors.red,
              //       height: 30,
              //       width: 10,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );

    // return Card(
    //   child: Padding(
    //     padding: const EdgeInsets.all(40.0),
    //     child: IntrinsicHeight(
    //       child: Row(
    //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <Widget>[
    //           Container(
    //             decoration: BoxDecoration(
    //               border: Border.all(width: 2.0, color: Colors.blue),
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10.0),
    //               child: image,
    //             ),
    //           ),
    //           SizedBox(
    //             width: Get.width * 0.04,
    //           ),
    //           Expanded(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 RichText(
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                   text: TextSpan(
    //                     text: "Fecha de publicación: ",
    //                     style: const TextStyle(
    //                       color: Colors.grey,
    //                       fontStyle: FontStyle.italic,
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     children: <TextSpan>[
    //                       TextSpan(
    //                         text: DateHelper.getDateShortFormatWithBars(
    //                             listing.datePublication),
    //                         style: const TextStyle(
    //                           color: Color(0xff092044),
    //                           fontStyle: FontStyle.normal,
    //                           fontSize: 20,
    //                           fontWeight: FontWeight.w900,
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 RichText(
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                   text: TextSpan(
    //                     text: "Provincia: ",
    //                     style: const TextStyle(
    //                       color: Colors.grey,
    //                       fontStyle: FontStyle.italic,
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     children: <TextSpan>[
    //                       TextSpan(
    //                         text: listing.address!.province,
    //                         style: const TextStyle(
    //                           color: Color(0xff092044),
    //                           fontStyle: FontStyle.normal,
    //                           fontSize: 20,
    //                           fontWeight: FontWeight.w900,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 RichText(
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                   text: TextSpan(
    //                     text: "Municipio: ",
    //                     style: const TextStyle(
    //                       color: Colors.grey,
    //                       fontStyle: FontStyle.italic,
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     children: <TextSpan>[
    //                       TextSpan(
    //                         text: listing.address!.municipality,
    //                         style: const TextStyle(
    //                           color: Color(0xff092044),
    //                           fontStyle: FontStyle.normal,
    //                           fontSize: 20,
    //                           fontWeight: FontWeight.w900,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 RichText(
    //                   maxLines: 3,
    //                   overflow: TextOverflow.ellipsis,
    //                   text: TextSpan(
    //                     text: "Descripción: ",
    //                     style: const TextStyle(
    //                       color: Colors.grey,
    //                       fontStyle: FontStyle.italic,
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     children: <TextSpan>[
    //                       TextSpan(
    //                         text: listing.description,
    //                         style: const TextStyle(
    //                           color: Color(0xff092044),
    //                           fontStyle: FontStyle.normal,
    //                           fontSize: 20,
    //                           fontWeight: FontWeight.w900,
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             width: Get.width * 0.03,
    //           ),
    //           Text(
    //             '${listing.price.toString()}€',
    //             style: const TextStyle(
    //               // color: Colors.red,
    //                 color: Color(0xff092044),
    //                 fontWeight: FontWeight.w900,
    //                 fontSize: 40.0,
    //                 fontStyle: FontStyle.italic),
    //           ),
    //           if (authProvider.authStatus == AuthStatus.authenticated)
    //             const SizedBox(
    //               width: 30,
    //             ),
    //           if (authProvider.authStatus == AuthStatus.authenticated)
    //             Align(
    //               alignment: Alignment.topRight,
    //               child: Container(
    //                 color: Colors.red,
    //                 height: 30,
    //                 width: 10,
    //               ),
    //             ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
