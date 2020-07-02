import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/views/login/login_screen.dart';
import 'package:grupocsl/views/splash/splash_screen.dart';


void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/splash',
      locale: Locale('pt', 'BR'),
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
      ],
      theme: ThemeData(
        fontFamily: 'FredokaOne',
        primaryColor: const Color(0xff48c2e7),
        primarySwatch: Colors.blue[200]
      ),
    ),
  );
}