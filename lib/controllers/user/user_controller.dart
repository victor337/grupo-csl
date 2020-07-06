import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/model/errors/errors_model.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/model/user/user_model.dart';
import 'package:http/http.dart' as http;



class UserController extends GetxController {

  bool isLoading = false;

  final String urlAuth = 'https://sisteste.carroesofalimpo.com.br/api/autentica.php';

  UserModel user;
  
  // final GetStorage box = GetStorage();

  // void saveData(Map<String, dynamic> data){
  //   final String date = DateTime.now().toString().substring(0, 10);
  //   box.write('user', {
  //     "id": data['id'] as String,
  //     "idAux": data['idAux'] as String,
  //     "nome": data['nome'] as String,
  //     "tipo": data['tipo'] as String,
  //     "idFunc": data['idFunc'] as String,
  //     "token": data['token'] as String,
  //     "franquia": data['franquia'] as String,
  //     "data": date
  //   });
  //   final userData = json.encode(data);
  //   final response = json.decode(userData);
  //   user = UserModel.fromMap(response as Map<String, dynamic>);
  //   update();
  // }

  // void deleteUserData(){
  //   box.remove('user');
  //   user = null;
  // }

  // Future<bool> readToken()async{
  //   final Map<String, dynamic> userData = await box.read('user');
  //   print(userData);
  //   if(userData == null){
  //     return false;
  //   }
  //   else{
  //     if(userData["data"] == DateTime.now().toString().substring(0, 10)){
  //       saveData(userData);
  //       print(user.nome);
  //       update();
  //       return true;
  //     }
  //     else{
  //       box.remove('user');
  //       return false;
  //     }
  //   }
  // }

  String date = '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
  String dateFormated =
    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  DateTime dateNotFormated = DateTime(DateTime.now().year,
  DateTime.now().month,DateTime.now().day,);

  final String urlList = 'https://sisteste.carroesofalimpo.com.br/api/listaOS.php';

  List<OrderService> orders = [];

  List<OrderService> ordersFilter = [];

  String filter;
  void setFilter(String setFilter){
    filter = setFilter;
    ordersFilter.clear();
    ordersFilter.addAll(orders.where((e) => e.id.contains(filter)));
    update();
  }


  Future<void> findOrders({
    @required UserModel user,
  }) async{

    isLoading = true;
    update();
    final response = await http.post(
      urlList,
      body: {
        'token': user.token,
        'data': dateNotFormated.toString().substring(0, 10)
      }
    );
    final responseData = json.decode(response.body);
    if(responseData != null){
      
      orders.clear();
      for(final map in responseData){
        orders.add(OrderService.fromMap(map as Map<String, dynamic>));
      }
      isLoading = false;
      update();
    }else{
      isLoading = false;
      update();
    }
  }

  void setDate(DateTime data){
    dateNotFormated = data;
    final String dateFormated = '${data.day}/${data.month}/${data.year}';
    this.dateFormated = dateFormated;
    update();
  }

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
        findOrders(user: user);
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