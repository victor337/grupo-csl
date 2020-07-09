import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/repository/api.dart';
import 'package:http/http.dart' as http;


class PhotoBeforeController extends GetxController {

  List<String> images = [];

  void addImage(String file){
    images.add(file);
    update();
  }

  void removerImage(int index){
    images.removeAt(index);
    update();
  }

  void clearList(){
    images.clear();
    update();
  }

  Future<void> sendImage({
    @required String token,
    @required String os,
    @required String image,
    @required String tipo,
    @required String name,
    @required Function onSucess,
    @required Function(String) onFail,
  })async{
    final response = await http.post(
      '$urlBase/api/fotosOS.php',
      body: {
         'token': token,
         'os': os,
         'image': image,
         'tipo': tipo,
         'name': name,
      }
    );
    final responseData = json.decode(response.body);
    if(!responseData.toString().contains('errors')){
      onSucess();
      update();
    } else {
      onFail(responseData['errors']['title'] as String);
      update();
    }
  }


}