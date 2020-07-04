import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/bindings/auth_binding.dart';
import 'package:grupocsl/views/base/base_screen.dart';
import 'package:grupocsl/views/login/login_screen.dart';
import 'package:grupocsl/views/splash/splash_screen.dart';


void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/splash',
      locale: const Locale('pt', 'BR'),
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          transition: Transition.rightToLeft
        ),
        GetPage(
          name: '/base',
          page: () => BaseScreen(),
          transition: Transition.rightToLeft,
          binding: AuthBinding(),
        ),
      ],
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: const Color.fromARGB(255, 25, 108, 161),
      ),
    ),
  );
}