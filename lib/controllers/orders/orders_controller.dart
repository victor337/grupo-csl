import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:http/http.dart' as http;


class OrdersController extends GetxController {

  String date = '2020-07-03'; // '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  DateTime dateNotFormated = DateTime(DateTime.now().year, 
  DateTime.now().month,DateTime.now().day, );

  bool isLoading = false;

  final String urlList = 'https://sisteste.carroesofalimpo.com.br/api/listaOS.php';


  List<OrderService> orders = [];

  Future<void> findOrders({
    @required String token,
    @required Function onSucess,
    @required Function onFail,
  }) async{
    final response = await http.post(
      urlList,
      body: {
        'token': token,
        'data': '2020-07-03'
      }
    );
    final responseData = json.decode(response.body);
    if(responseData != null){
      for(final map in responseData){
        orders.add(OrderService.fromMap(map as Map<String, dynamic>));
      }
      onSucess();
      update();
    }else{
      onFail();
      update();
    }
  }

  void setDate(DateTime data){
    dateNotFormated = data;
    final String dateFormated = '${data.day}/${data.month}/${data.year}';
    date = dateFormated;
    update();
  }

}