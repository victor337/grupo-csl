import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:transparent_image/transparent_image.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SizeScreen sizeScreen = SizeScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<UserController>(
          init: UserController(),
          initState: (_)async{
            final bool value = await UserController().readToken();
            await Future.delayed(const Duration(seconds: 2));
            if(value){
              Get.offNamed('/base');
            } else{
              Get.offNamed('/login');
            }
          },
          builder: (userController){
            return Container(
              height: sizeScreen.getHeightScreen(context),
              width: sizeScreen.getWidthScreen(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [
                    Color(0xff48c2e7),
                    Color(0xff196ca1),
                  ]
                ),
              ),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: 'http://www.carroesofalimpo.com.br/img/logo.png'
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}