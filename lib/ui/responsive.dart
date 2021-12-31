import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  const Responsive({
    Key? key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  }) : super(key: key);

  /// This size work fine on my design, maybe you need some customization depends on your design

  /// This isMobile, isTablet, isDesktop helped us later
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      /// If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        }

        /// If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 650) {
          return tablet;
        }

        /// Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}
