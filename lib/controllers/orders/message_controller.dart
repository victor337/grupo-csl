import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class MessageController extends GetxController {


  Future<Map<String,dynamic>> setMessage() async{
    final response = await http.get(
      'https://sisteste.carroesofalimpo.com.br/api/texto.php',
    );

    final responseData = json.decode(response.body);

    update();
    return responseData as Map<String, dynamic>;
  }
}