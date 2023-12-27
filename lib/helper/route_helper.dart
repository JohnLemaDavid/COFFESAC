import 'package:efood_table_booking/helper/responsive_helper.dart';
import 'package:efood_table_booking/view/base/animated_dialog.dart';
import 'package:efood_table_booking/view/screens/home/home_screen.dart';
import 'package:efood_table_booking/view/screens/punto_azul/registro_persona_screen.dart';
import 'package:efood_table_booking/view/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/config/configuration_screen.dart';
import '../view/screens/punto_azul/login_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String config = '/config';
  static const String prospecto = '/prospecto';

  static getInitialRoute() => initial;
  static getSplashRoute() => splash;
  static getHomeRoute(String name) => '$home?name=$name';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: config, page: () => const ConfigurationScreen()),
    GetPage(name: prospecto, page: () => const FormularioPersonaScreen()),
    GetPage(
      name: home, page: () => const HomeScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];

  static void openDialog(BuildContext context, Widget child, {bool isDismissible = true}) {
    !ResponsiveHelper.isTab(context) ?
    Get.bottomSheet(isDismissible: isDismissible, child, backgroundColor: Colors.transparent,
      enterBottomSheetDuration:  const Duration(milliseconds: 100),
      isScrollControlled: true,) :
    // Get.dialog(
    //   useSafeArea: true,
    //
    //   transitionDuration: Duration(milliseconds: 300),
    //   Dialog(backgroundColor: Colors.transparent, child:  child,),
    // );
    showAnimatedDialog(
      context: context,
      duration: const Duration(milliseconds: 200),
      barrierDismissible: isDismissible,

      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child:  child,
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
    );
  }

}