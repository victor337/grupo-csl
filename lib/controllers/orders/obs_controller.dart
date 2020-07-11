import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/repository/api.dart';
import 'package:http/http.dart' as http;


class ObsController extends GetxController {

  String initalObs;

  String obs;
  void setObs(String newObs){
    obs = newObs;
    update();
  }

  Future<Map<String, dynamic>> getObs({
    @required String token,
    @required String os,
    @required Function onSucess,
    @required Function onFail,
  })async{
    final response = await http.post(
      '$urlBase/api/observacaoOS.php',
      body: {
        'token': token,
        'os': os,
      }
    );

    final responseData = json.decode(response.body);
    if(!responseData.toString().contains("errors")){
      initalObs = responseData['success']['observacoes'] as String;
      onSucess();
      update();
      return responseData as Map<String, dynamic>;
    } else {
      onFail(responseData['errors']['title'] as String);
      update();
      return responseData as Map<String, dynamic>;
    }
  }

  String observations;

  bool isLoading = false;

  Future<void> sendObservation({
    @required String token,
    @required String os,
    @required String setObs,
    @required Function onSucess,
    @required Function onFail,
  })async{

    isLoading = true;
    update();

    final response = await http.post(
      '$urlBase/api/observacaoOS.php',
      body: {
        'token': token,
        'os': os,
        'observacoes': setObs
      }
    );

    final responseData = json.decode(response.body);
    if(!responseData.toString().contains("errors")){
      observations = responseData['success']['observacoes'] as String;
      onSucess();
      isLoading = false;
      update();
    } else {
      onFail();
      isLoading = false;
      update();
    }
  }


}