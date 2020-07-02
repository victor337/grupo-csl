import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xff48c2e7),
              const Color(0xff196ca1),
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((value){
      Get.offNamed('/login');
    });
  }

}