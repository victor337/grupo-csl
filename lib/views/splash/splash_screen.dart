import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:transparent_image/transparent_image.dart';


class SplashScreen extends StatelessWidget {

  final SizeScreen sizeScreen = SizeScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<UserController>(
          init: UserController(),
          builder: (userController){
            userController.readUserLocal(
              login: (){
                Get.offNamed('/login');
              },
              base: (user){
                userController.login(
                  login: user['login'] as String,
                  pass: user['pass'] as String,
                  ordersSucess: (){
                    Get.snackbar(
                      'Atualizado',
                      'Os pedidos foram buscados!',
                      colorText: Colors.white,
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2)
                    );
                  },
                  onError: (e){
                    Get.snackbar(
                      'Nada por hoje',
                      'Não há pedidos para está data',
                      colorText: Colors.white,
                      backgroundColor: Colors.grey,
                      duration: const Duration(seconds: 2)
                    );
                  },
                  onSucess: (){
                    print('Entrou aqui');
                    Get.offAllNamed('/base');
                    Get.snackbar(
                      'Sucesso',
                      'Você logou com sucesso',
                      colorText: Colors.white,
                      backgroundColor: const Color(0xff48c2e7),
                      duration: const Duration(seconds: 1)
                    );
                  },
                  authFail: (erro){
                    Get.snackbar(
                      'Falha: ${erro.code}',
                      erro.title,
                      colorText: Colors.white,
                      backgroundColor: Colors.red
                    );
                  },
                  onFail: (e){
                    Get.snackbar(
                      'Erro', 'Erro desconhecido.',
                      colorText: Colors.white,
                      backgroundColor: Colors.red
                    );
                  },
                  remeber: false,
                );
              }
            );
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