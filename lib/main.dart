import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grupocsl/bindings/auth_binding.dart';
import 'package:grupocsl/bindings/base_binding.dart';
import 'package:grupocsl/bindings/payment_binding.dart';
import 'package:grupocsl/bindings/photos_before.dart';
import 'package:grupocsl/views/base/base_screen.dart';
import 'package:grupocsl/views/login/login_screen.dart';
import 'package:grupocsl/bindings/photos_after.dart';
import 'package:grupocsl/views/splash/splash_screen.dart';


Future<void> main() async{
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      initialRoute: '/splash',
      locale: const Locale('pt', 'BR'),
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
          bindings: [
            PhotosAfter(),
            PhotoBefore(),
            AuthBinding(),
            PaymentBinding(),
          ],
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          transition: Transition.rightToLeft,
          binding: AuthBinding(),
          transitionDuration: const Duration(milliseconds: 80)
        ),
        GetPage(
          name: '/base',
          page: () => BaseScreen(),
          transition: Transition.rightToLeft,
          bindings: [
            BaseBinding(),
            PhotosAfter(),
            PhotoBefore(),
            AuthBinding(),
            PaymentBinding(),
          ],
          transitionDuration: const Duration(milliseconds: 80)
        ),
      ],
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: const Color.fromARGB(255, 25, 108, 161),
      ),
    ),
  );
}