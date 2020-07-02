import 'package:get/get.dart';


class LoginController extends GetxController {

  String login;
  void setlogin(String setlogin){
    login = setlogin;
    update();
  }

  String pass;
  void setPass(String setPass){
    pass = setPass;
    update();
  }

  bool get isValid => login != null && login != '' &&
    pass != null && pass != '';

}