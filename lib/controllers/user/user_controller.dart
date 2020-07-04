import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/model/user/user_model.dart';
import 'package:http/http.dart' as http;


class UserController extends GetxController {

  bool isLoading = false;

  final String urlAuth = 'https://sisteste.carroesofalimpo.com.br/api/autentica.php';

  UserModel user;


  //Função para iniciar sessão
  Future<void> login({
    @required String login,
    @required String pass,
    @required Function onSucess,
    @required Function(String) onFail,
    @required Function authFail,
  })async{

    isLoading = true;
    update();

    try {
      final response = await http.post(urlAuth, body: {'usuario': login, 'senha': pass});
      final responseData = json.decode(response.body);
      user = UserModel.fromMap(responseData as Map<String, dynamic>);
      if(user.nome != null){
        isLoading = false;
        onSucess();
        update();
      }else{
        isLoading = false;
        authFail();
        update();
      }
      
    } catch (e) {
      isLoading = false;
      onFail(e.toString());
      update();
    }

  }

}