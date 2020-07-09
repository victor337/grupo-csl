import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/repository/api.dart';
import 'package:http/http.dart' as http;


class PaymentController extends GetxController {


  String optionSelect;
  String value;

  bool isLoading = false;

  void setOption(String option){
    optionSelect = option;
    update();
  }
  
  void setValue(String setValue){
    value = setValue;
    update();
  }

  String setTypePayment(String type){
    if(type == 'Cartão de crédito 1x'){
      return '1';
    } else if(type == 'Cartão de Débito'){
      return '2';
    } else if(type == 'Dinheiro'){
      return '3';
    } else if(type == 'Transferência'){
      return '4';
    } else if(type == 'Cartão de Crédito'){
      return '5';
    } else if(type == 'Cartão de Crédito 3x'){
      return '6';
    } else {
      return 'Tipo inválido';
    }
  }

  List<String> options = [
    'Cartão de crédito 1x',
    'Cartão de Débito',
    'Dinheiro',
    'Tranferência',
    'Cartão de Crédito 2x',
    'Cartão de Crédito 3x',
  ];

  String date = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  DateTime dateNotFormated = DateTime(DateTime.now().year, 
    DateTime.now().month,DateTime.now().day, );

  void setDate(DateTime data){
    dateNotFormated = data;
    print(dateNotFormated);
    final String dateFormated = '${data.day}/${data.month}/${data.year}';
    date = dateFormated;
    update();
  }

  bool get isValid => optionSelect != null && value != null &&
  value != '';

  Future<void> sendPayment({
    @required String token,
    @required String os,
  })async{
    final response = await http.post(
      '$urlBase/api/pagamentoOS.php',
      body: {
        'token': token,
        'os': os,
        'idPagamento': null,
        'dataPagamento': dateNotFormated.toString().substring(0, 10),
        'valor': value,
        'tipoPagamento': '1',
        'formaPagamento': setTypePayment(optionSelect),
      }
    );

    final responseData = json.decode(response.body);
    print(responseData);

  }

}