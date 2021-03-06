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
    setValue.replaceAll('.', '').replaceAll(',', '.');
    value = setValue;
    update();
  }

  Map<String, dynamic> snapshot;

  Future<void> verifypayment({
    @required String token,
    @required String os,
  })async{
    final response = await http.post(
      '$urlBase/api/pagamentoOS.php',
      body: {
        'token': token,
        'os': os,
      }
    );
    final responseData = json.decode(response.body);
    snapshot = responseData[0] as Map<String, dynamic>;
    return responseData;

  }

  String setTypePayment(String type){
    if(type == 'Cartão de crédito 1x'){
      return '1';
    } else if(type == 'Cartão de Débito'){
      return '2';
    } else if(type == 'Dinheiro'){
      return '3';
    } else if(type == 'Tranferência'){
      return '4';
    } else if(type == 'Cartão de Crédito 2x'){
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
    final String dateFormated = '${data.day}/${data.month}/${data.year}';
    date = dateFormated;
    update();
  }

  bool get isValid => optionSelect != null && value != null &&
  value != '';

  Future<void> sendPayment({
    @required String token,
    @required String os,
    @required String idPay,
    @required Function onSucess,
    @required Function(String) onFail,
    @required String type,
    @required String dataParam,
    @required String valueParam,
    @required String form,
  })async{
    

    isLoading = true;
    update();

    final response = await http.post(
      '$urlBase/api/pagamentoOS.php',
      body: {
        'token': token,
        'os': os,
        'idPagamento': idPay,
        'dataPagamento': dataParam,
        'valor': valueParam,
        'tipoPagamento': '1',
        'formaPagamento': form
      }
    );

    final responseData = json.decode(response.body);
    if(!responseData.toString().contains("errors")){
      isLoading = false;
      onSucess();
      update();
    } else {
      isLoading = false;
      onFail(responseData['errors']['title'] as String);
      update();
    }

  }

}