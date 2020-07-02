import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserController extends GetxController {

  bool isLoading = false;

  //Função para iniciar sessão
  Future<void> login({@required Function teste})async{

    isLoading = true;
    update();

    await Future.delayed(const Duration(seconds: 3));

    isLoading = false;
    teste();
    update();

  }

}