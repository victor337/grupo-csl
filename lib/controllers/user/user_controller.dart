import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grupocsl/model/errors/errors_model.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/model/user/user_model.dart';
import 'package:grupocsl/repository/api.dart';
import 'package:http/http.dart' as http;



class UserController extends GetxController {

  bool isLoading = false;

  final GetStorage getStorage = GetStorage();

  final String urlAuth = '$urlBase/api/autentica.php';
  final String urlList = '$urlBase/api/listaOS.php';
  final String urlStatus = '$urlBase/api/atualizaOS.php';

  UserModel user;

  Future<void> setStatusOrder({
    @required String token,
    @required String os,
    @required int index,
    @required String status,
    @required Function(Error) onFail,
    @required Function onSucess,
    @required Function onOrders,
  })async{
    textIsLoading = true;
    update();
    final response = await http.post(
      urlStatus,
      body: {
        'token': token,
        'os': os,
        'statusAtendimento': status
      }
    );
    final responseData = json.decode(response.body);
    if(!responseData.toString().contains("errors")){
      setOrderStatusInList(index, responseData[0]['statusAtendimento'] as String);
      onSucess();
      textIsLoading = false;
      update();
    } else{
      onFail(Error.fromMap(responseData as Map<String, dynamic>));
      textIsLoading = false;
      update();
    }
  }

  String date = '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
  String dateFormated =
    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  DateTime dateNotFormated = DateTime(DateTime.now().year,
  DateTime.now().month,DateTime.now().day,);

  List<OrderService> orders = [];

  List<OrderService> ordersFilter = [];

  String filter;
  void setFilter(String setFilter){
    filter = setFilter;
    ordersFilter.clear();
    ordersFilter.addAll(orders.where((e) => e.id.contains(filter)));
    update();
  }

  bool textIsLoading = false;

  void setOrderStatusInList(int index, String seStatus){
    orders[index].statusAttendance = seStatus;
    update();
  }


  Future<void> findOrders({
    @required UserModel user,
    @required Function(Error) onError,
    @required Function onSucess
  }) async{

    isLoading = true;
    update();
    final response = await http.post(
      urlList,
      body: {
        'token': user.token,
        'data': dateNotFormated.toString().substring(0, 10),
      }
    );
    final responseData = json.decode(response.body);
    if(!responseData.toString().contains("errors")){
      orders.clear();
      for(final map in responseData){
        orders.add(OrderService.fromMap(map as Map<String, dynamic>));
      }
      isLoading = false;
      onSucess();
      update();
    }
    else {
      orders.clear();
      isLoading = false;
      onError(Error.fromMap(responseData as Map<String, dynamic>)).toString();
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
    @required Function(Error) onError,
    @required Function ordersSucess,
    @required bool remeber,
  })async{

    isLoading = true;
    update();

    try {
      final response = await http.post(urlAuth, body: {'usuario': login, 'senha': pass});
      final responseData = json.decode(response.body);
      user = UserModel.fromMap(responseData as Map<String, dynamic>);
      if(user.nome != null){
        isLoading = false;
        if(remeber){
          final Map<String, dynamic> userData = {
            'login': login,
            'pass': pass,
            'token': user.token,
            'date': '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
          };
          saveUserLocal(userData);
        } 
        findOrders(
          user: user,
          onSucess: ordersSucess,
          onError: onError,
        );
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

  Future<void> deleteUserLocal()async{
    await getStorage.remove('user');
  }  

  Future<void> saveUserLocal(Map<String, dynamic> data)async{
    await getStorage.write('user', data);
  }

  Future<void> readUserLocal({
    @required Function login,
    @required Function(Map<String, dynamic>) base,
  })async{
    final String dateNow = 
      '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}';
    final Map<String, dynamic> user = await getStorage.read('user');
    if(user == null){
      login();
    } else if(user['date'] != dateNow){
      login();
    } else {
      base(user);
    }
  }  
}