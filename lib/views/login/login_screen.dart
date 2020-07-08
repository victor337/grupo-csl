import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/login/login_controller.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/views/login/components/custom_form_field.dart';
import 'package:transparent_image/transparent_image.dart';



class LoginScreen extends StatelessWidget {

  final FocusNode focusLogin = FocusNode();
  final FocusNode focusPass = FocusNode();

  final SizeScreen sizeScreen = SizeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Text(
              'Login',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
          width:  sizeScreen.getWidthScreen(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [
                Color(0xff196ca1),
                Color(0xff48c2e7),
              ]
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: sizeScreen.getHeightScreen(context) / 6,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: 'http://www.carroesofalimpo.com.br/img/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                  ],
                ),
                GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (loginController){
                    return CustomFormField(
                      focusNode: focusLogin,
                      onChanged: (login){
                        loginController.setlogin(login);
                      },
                      hintText: 'Seu login',
                      onFieldSubmitted: (text){
                        focusLogin.unfocus();
                        FocusScope.of(context).requestFocus(focusPass);
                      },
                      textInputAction: TextInputAction.next,
                      keyBoardType: TextInputType.emailAddress,
                      iconData: Icons.email
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Senha',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                  ],
                ),
                GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (loginController){
                    return CustomFormField(
                      focusNode: focusPass,
                      onChanged: (pass){
                        loginController.setPass(pass);
                      },
                      hintText: 'Sua senha',
                      onFieldSubmitted: (text){
                        focusPass.unfocus();
                      },
                      textInputAction: TextInputAction.done,
                      keyBoardType: TextInputType.emailAddress,
                      iconData: Icons.lock
                    );
                  },
                ),
                const SizedBox(height: 20,),
                GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (loginController){
                    return GetBuilder<UserController>(
                      init: UserController(),
                      builder: (userController){
                        return Container(
                          width: sizeScreen.getWidthScreen(context),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            disabledColor: Colors.grey,
                            onPressed: loginController.isValid ?(){
                              userController.login(
                                login: loginController.login,
                                pass: loginController.pass,
                                ordersSucess: (){
                                  Get.snackbar(
                                    'Atualizado',
                                    'Os pedidos foram buscados!',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.green,
                                    duration: const Duration(seconds: 1)
                                  );
                                },
                                onError: (e){
                                  Get.snackbar(
                                    e.code,
                                    'Não há pedidos para está data',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.grey,
                                    duration: const Duration(seconds: 1)
                                  );
                                },
                                onSucess: (){
                                  Get.offAllNamed('/base');
                                  Get.snackbar(
                                    'Sucesso',
                                    'Você logou com sucesso',
                                    colorText: Colors.white,
                                    backgroundColor: const Color(0xff48c2e7),
                                    duration: const Duration(seconds: 1)
                                  );
                                },
                                authFail: (erro){
                                  Get.snackbar(
                                    'Falha: ${erro.code}',
                                    erro.title,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red
                                  );
                                },
                                onFail: (e){
                                  Get.snackbar(
                                    'Erro', 'Erro desconhecido.',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red
                                  );
                                }
                              );
                            } : null,
                            child: userController.isLoading ?
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                            ) :  Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10) ,
                              child: const Text(
                                "Entrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}