import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/model/errors/errors_model.dart';
import 'package:grupocsl/model/user/user_model.dart';
import 'package:http/http.dart' as http;



class UserController extends GetxController {

  String tokenUser = '4084d68a42351aec51588bbbf87ffcfc640200ec';

  bool isLoading = false;

  final String urlAuth = 'https://sisteste.carroesofalimpo.com.br/api/autentica.php';

  UserModel user;


  //Função para iniciar sessão
  Future<void> login({
    @required String login,
    @required String pass,
    @required Function onSucess,
    @required Function(String) onFail,
    @required Function(Error) authFail,
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
        authFail(Error.fromMap(responseData['errors'] as Map<String, dynamic>));
        update();
      }
      
    } catch (e) {
      isLoading = false;
      onFail(e.toString());
      update();
    }

  }

}