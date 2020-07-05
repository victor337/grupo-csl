import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:http/http.dart' as http;


class OrdersController extends GetxController {

  String date = '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
  String dateFormated =
    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  DateTime dateNotFormated = DateTime(DateTime.now().year,
  DateTime.now().month,DateTime.now().day,);

  bool isLoading = false;

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
    @required String token,
  }) async{

    isLoading = true;
    update();
    final response = await http.post(
      urlList,
      body: {
        'token': token,
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

}